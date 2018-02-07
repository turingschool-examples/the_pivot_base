class CartDecorator < SimpleDelegator

  #have access here to all methods in Cart

  def items_with_quantity #BUGGY bc a hash can't have 2 identical keys...might have to change back to Item as the key
    contents.inject({}) do |result, (item_id, quantity)|
      result[Item.find(item_id)] = quantity
      result
    end
  end

  def sub_total(quantity)  #(called off one instance of Item)
    price * quantity
  end

  def total # qty would be @cart_items.contents.keys (but looped in |id, qty|)
    items_with_quantity.map do |item, quantity|
      item.price * quantity
    end.sum
  end #?

end



=begin

  or instead of inheriting from delegator, I do something like this:

class CartDecorator

  def initialize(cart) --->(pass the Object...or try inheritance?)
    @cart_contents_hash = cart.contents (so that I have all the methods?)
    @cart_contents_hash.each do |id, qty|
      CartItem.new(Item.find(id), qty) ---> make a CartItem class that has a qty method. does it make a new one each time we load a page, and makes a DB call?
    end
  end

  def other_methods?

  end


end (of the class)


BUT THIS MAKES AN EXTRA CLASS AND SO MUCH MORE THAN THE HASH METHOD ABOVE.








=end
