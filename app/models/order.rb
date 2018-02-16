class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items
  has_many :order_items
  has_many :stores, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def total_price
    items.sum(:price)
  end



  def date
    created_at.strftime('%b. %d, %Y')
  end

  def self.count_by_status
    group(:status).count
  end

  def self.filter_by_status(status)
    where(status: status)
  end

  def self.count_of_completed_orders
    where(status: :completed).count
  end

  def self.shop_total_gross
		where(status: :completed).joins(:items).sum(:price)
  end


  def order_total(order) #based off a user's order
    price_and_quantity(order).map do |price, quantity|
      price * quantity
    end.sum
  end


  def price_and_quantity(order)
    hash = {}
    order_items.each do |item|
      hash[item.unit_price] = item.quantity
    end
    hash
  end

  def self.filter_by_status(status)
    where(status: status)
  end

  def create_order_with_associations(user, cart)
    cart_items = cart.contents.map do |item_id, quantity|
      CartItem.new(item_id, quantity)
    end

    order = Order.create(status: "ordered", user_id: user.id, total: order_total(order))

    cart_items.each do |cart_item|
      OrderItem.create(item_id: cart_item.item.id, order_id: order.id, quantity: cart_item.quantity, unit_price: cart_item.item.price, store_id: cart_item.store.id)
    end

    # order_item.update(store_id: item.store_id, unit_price: item.price)
    # order_total = OrderItem.where(order_id: order.id).map{|oi| oi.unit_price * oi.quantity}.sum
    # order.update(total: order_total)

  end

#This method might only be used in tests.
  def items_with_quantity(cart_hash)
    cart_hash.contents.inject({}) do |hash, (item_id, quantity)|
      hash[Item.find(item_id)] = quantity
      hash
    end
  end


end
