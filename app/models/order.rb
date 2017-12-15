class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def self.get_orders_by_status(status)
    if status == "ordered" || status == "paid" || status == "cancelled" || status == "completed"
      return Order.filter_by_status(status)
    else
      Order.all
    end
  end

  def total_price
    order_items.map do |f|
      f.quantity * f.unit_price
    end.sum
  end

  def add(item_hash)
    item_hash.each do |item, quantity|
      items << item
      order_item = OrderItem.find_by(order: self, item_id: item.id)
      order_item.update(quantity: quantity)
      order_item.update(unit_price: item.price)
    end
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


end
