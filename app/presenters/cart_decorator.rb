class CartDecorator < SimpleDelegator
  #wraps Cart.rb



  def cart_item_objects #array of objects
    #contents is from session which creates Cart.rb instance
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
