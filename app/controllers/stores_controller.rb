class StoresController < ApplicationController

  def show
    @store = Store.find_by(name: params[:store_name])
    @items = @store.items

  end
end
