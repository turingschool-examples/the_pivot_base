class Stores::ItemsController < ApplicationController 
  def index 
    store = Store.find_by(slug: params[:store])
    @items = store.items
  end
end