class Stores::ItemsController < ApplicationController

  def index
    @store = Store.find_by_slug!(params['store'])
    @items = @store.items
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @store = Store.find_by_slug!(params['store'])
    @item = @store.items.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @categories = Category.all
    @item = Item.new(item_params)
    @item.store = Store.find_by_slug!(params['store'])
    
    if @item.save
      redirect_to store_items_path(@item.store)
    else
      render :new
    end
  end

  def update
    @categories = Category.all
    @item = Item.find(params[:id])
    @item.store = @item.store
    @item.update(item_params)
    if @item.save
      redirect_to store_items_path(@item.store)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end

end