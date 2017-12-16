class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @store = current_user.stores.find_by(id: params[:store_name])
    @item = Item.new
  end

  def create
    binding.pry
    @categories = Category.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def update
    @categories = Category.all
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end
end
