class Admin::ItemsController < ApplicationController
  before_action :require_admin
  before_action :find_store

  def index
    @store_items = StoreItemPresenter.new(store)
  end

  def new
    @item = Item.new(store: store)
  end

  def create
    @categories = Category.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_store_items_path(store)
    else
      render :new
    end
  end

  def update
    @categories = Category.all
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to admin_store_items_path(store)
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private
  attr_reader :store

    def find_store
      @store = Store.find_by(slug: params["store_slug"])
    end

    def item_params
      params.require(:item).permit(:title, :description, :price, :image, :category_id, :store_id)
    end

    def require_admin
      render file: "/public/404" unless current_admin?
    end
end
