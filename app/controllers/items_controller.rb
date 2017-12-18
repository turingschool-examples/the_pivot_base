class ItemsController < ApplicationController
  def index
    store  = Store.find_by(slug: params[:store])
    @items = store.items
  end

  def show
    @item = Item.find(params[:id])
  end
end
