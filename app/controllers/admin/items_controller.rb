class Admin::ItemsController < ApplicationController
  def index
    @store = current_user.stores.find_by(url: params[:store_name])
  end

  def show
    @store = current_user.stores.find_by(url: params[:store_name])
    @item = @store.items.find_by(url: params[:item_name])
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
    @item = @store.items.find_by(url: params[:item_name])
    @item.update(item_params)
    if @item.save
      redirect_to admin_store_item_path(@store.url, @item.url)
    else
      render :edit
    end
  end

  def edit
    @store = current_user.stores.find_by(url: params[:store_name])
    @item = @store.items.find_by(url: params[:item_name])
  end

  def destroy
    @store = current_user.stores.find_by(url: params[:store_name])
    @item = @store.items.find_by(url: params[:item_name])
    @item.destroy

    flash[:success] = "#{@item.title} was successfully deleted!"
    redirect_to admin_store_items_path(@store.url)
  end

  private


  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end
end
