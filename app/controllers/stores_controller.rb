class StoresController < ApplicationController

  def show
    @items = Store.find_by(name: params[:store_name]).items
  end
end  
