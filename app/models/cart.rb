class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total_count
    contents.values.sum
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def decrease_quantity(id)
    if contents[id.to_s] > 0
      contents[id.to_s] -=1
    end
    if contents[id.to_s] == 0
      delete_item(id)
    end
  end

  def increase_quantity(id)
    contents[id.to_s] += 1
  end

  def count_of(id)
    contents[id.to_s].to_i
  end


      # make sure that we account for items that have a different Store_id...or do we not have to worry about that for now?
     # contents  - key is the item id and value is the qty of that item
    #  I want to pass this to the controller so that I have access to the Item objects and their columns, along with the qty.

    # as of now in the view, we need each cart-item's name, price, quantity, and subtotal. we need to be able to iterate over this object.
    # contents.each do |item_id, quantity|
    #   item.name(item_id)
    #   item.price(item_id)
    #   item.quantity
    #   item.subtotal(item_id, quantity)
    # end 
    def cart_item(item_id) 
      Item.find(item_id)
    end 

    
    # def item_id(key)
    #   Item.find(key).id
    # end 
    
    # def item_image(key)
    #   Item.find(key).image
    # end 
    
    # def item_title(key)
    #   Item.find(key).title
    # end 
    
    # def item_price(key)
    #   Item.find(key).price
    # end 
    
    def item_subtotal(key, value)
      item_price(key) * value
    end 
    
  
    
    def item_total
      @contents.map do |key, value|
        item_price(key) * value
      end.sum
    end 


  
  # def cart_items
  #   contents.inject({}) do |result, (item_id, quantity)|
  #     result[Item.find(item_id)] = quantity
  #     result
  #   end
  # end

  def delete_item(id)
    contents.delete(id.to_s)
  end

  def destroy
    @contents.clear
  end

end
