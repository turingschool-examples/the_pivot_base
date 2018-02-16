class CartDecorator < SimpleDelegator

  def items #array of objects
    #contents is from session which creates Cart.rb instance
    contents.map do |item_id, quantity|
      CartItem.new(item_id, quantity)
    end
  end

  def total
    items.map do  |item|
      item.price * item.quantity
    end.sum
  end

end
