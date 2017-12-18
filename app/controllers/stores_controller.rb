class StoresController < ApplicationController

  def index
    @stores = Store.all
  end 

  def new
    @store = Store.new
  end 

  def create
    store = Store.create(name: params["store"]["name"], user: current_user )
    
    redirect_to dashboard_index_path
  end

  def update
    @store = Store.find(params[:id])
    @store.update!(status: params[:status])
    @store.save!
    redirect_back(fallback_location: root_path)
  end
end 
