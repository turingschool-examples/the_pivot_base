class StoresController < ApplicationController

  def index
    @store = current_user.store
  end 

  def new
    @store = Store.new
  end 

  def create
    store = Store.create(name: params["store"]["name"], user: current_user)
    redirect_to dashboard_index_path
  end 
end 
