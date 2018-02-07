class CartDecorator < SimpleDelegator

  #have access here to all methods in Cart

  def items_with_quantity
    contents.inject({}) do |result, (item_id, quantity)|
      result[quantity] = Item.find(item_id)
      result
    end
  end

  def sub_total(quantity)  #(called off one instance of Item)
    price * quantity
  end

  def total # qty would be @cart_items.contents.keys (but looped in |id, qty|)
    items_with_quantity.map do |quantity, item|
      item.price * quantity
    end.sum
  end #?

end
