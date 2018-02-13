class CartItem
  attr_reader :item, :quantity, :title, :description, :price, :image, :category, :store

  def initialize(item_id, quantity)
    @quantity = quantity
    @item = Item.find(item_id)
    @category = Category.find(@item.category_id)
    @store = Store.find(@item.store_id)
    @title = @item.title
    @description = @item.description
    @price = @item.price
    @image = @item.image
  end

  def sub_total
    price * quantity
  end


  def id
    item.id
  end
end
