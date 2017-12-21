class Order < ApplicationRecord
  validates  :status, presence: true

  belongs_to :user
  has_many   :order_items
  has_many   :items, through: :order_items
  has_one    :charge

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def total_price
    order_items.sum('order_items.price * order_items.quantity')
  end

  def add(item_hash)
    item_hash.each do |item, quantity|
      self.items << item
      save!(validate: false)
      order_item = OrderItem.find_or_create_by(order: self, item: item)
      order_item.update(quantity: quantity, price: item.price)
    end
  end

  def date
    created_at.strftime('%b. %d, %Y')
  end

  def self.count_by_status
    group(:status).count
  end

  def self.count_of_completed_orders
    where(status: :completed).count
  end

  def self.shop_total_gross
    where(status: :completed).joins(:items).sum('items.price')
  end

  def item_quantity(item)
    order_item = order_items.find_by(item: item)
    order_item.quantity
  end
end
