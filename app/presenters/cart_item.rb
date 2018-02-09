class CartItem
  attr_reader :item, :quantity, :title, :description, :price, :image, :category, :store_id

  def initialize(item_id, quantity)
    @item = Item.find(item_id)
    @quantity = quantity
    @title = @item.title
    @description = @item.description
    @price = @item.price
    @image = @item.image
    @category = Category.find(@item.category_id)
    @store = Store.find(@item.store_id)
  end

end 
