class ItemsController < ApplicationController
  def index
    store  = Store.find_by(slug: params[:store])
    @items = store.items.paginate(page: params[:page], per_page: 20)
  end

  def show
    @item = Item.find(params[:id])
  end
end
