class CartDecorator < SimpleDelegator

  #have access here to all methods in Cart (like contents, total_count, add_item, increase and decrease qty, destroy...)
  #have access to all CartItem methods

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



=begin

  I need to move from the hash to making the cart produce an object.

  the session cart is a hash. but I should turn the hash into a classlet asap.

=end
