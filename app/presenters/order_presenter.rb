class OrderPresenter < SimpleDelegator

  def initialize(order)
    super(order)
  end

  def total_price
    order.total_price
  end

  def add(item_hash)
    order.add(item_hash)
  end

  def date
    created_at.strftime('%b. %d, %Y')
  end 
 
  def order_total
    items.map do |item|
      item.price * item.quantity(self)
    end.reduce(:+)
  end

end