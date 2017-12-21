class StoresController < ApplicationController

  def index
    @stores = Store.active
  end

  def show
    @store = Store.friendly.find(params[:store])
  end

  def new
    @store = Store.new
  end

  def create
    if StoreService.create_proposed_store(current_user, params[:name])
      redirect_to "/dashboard"
    else
      flash[:message] = "Invalid Submission"
      redirect_to new_store_path
    end
  end

end
