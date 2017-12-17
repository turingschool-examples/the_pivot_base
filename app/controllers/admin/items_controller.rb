class Admin::ItemsController < ApplicationController
  def index
    @store = current_user.stores.find_by(url: params[:store_name])

  end

  def new
    @store = current_user.stores.find_by(url: params[:store_name])
    @item = Item.new
  end

  def create
    @store = current_user.stores.find_by(url: params[:store_name])
    @categories = Category.all
    @item = @store.items.new(item_params)
    if @item.save
      redirect_to admin_store_items_path(@store.url)
    else
      render :new
    end
  end

  def update
    @store = current_user.stores.find_by(url: params[:store_name])
    @categories = Category.all
    @item = @store.items.find_by(title: params[:item][:title])
    binding.pry
    @item.update(item_params)
    if @item.save
      redirect_to admin_store_items_path(@store.url)
    else
      render :edit
    end
  end

  def edit
    @store = current_user.stores.find_by(url: params[:store_name])
    @item = @store.items.find_by(url: params[:item_name])
  end

  private



  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end
end
