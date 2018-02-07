class CartDecorator < SimpleDelegator

  #have access here to all methods in Cart

  def items_with_quantity
    contents.inject({}) do |result, (item_id, quantity)|
      result[CartDecorator.new(Item.find(item_id))] = quantity
      result
    end
  end

  def sub_total(quantity) 
    price * quantity
  end

  def total
    items_with_quantity.map do |item, quantity|
      item.price * quantity
    end.sum
  end #?

end
