class CartDecorator < SimpleDelegator



  def cart_item_objects #array of objects
    contents.map do |item_id, quantity|
      CartItem.new(item_id, quantity)
    end
  end

  def total
    cart_item_objects.map do  |item|
      item.price * item.quantity
    end.sum

  end

end
