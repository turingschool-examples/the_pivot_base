class Stores::ItemsController < ApplicationController

  def index
    # byebug
    @store = Store.find(params['store'])
    @items = @store.items
  end
  
  def show
		@item = Item.find(params[:id])
  end

  def new
    @store = Store.find(params['store'])
    @item = @store.items.new
    # byebug
  end

  def create
    @categories = Category.all
    @item = Item.new(item_params)
    @item.store = params[:store_id]
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end

end