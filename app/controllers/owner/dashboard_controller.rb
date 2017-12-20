class Owner::DashboardController < ApplicationController
  before_action :require_owner

  def index
    
    @orders = Order.get_orders_by_status(params[:status])
    @store  = current_user.store
    flash[:notice] = "You're logged in as owner of #{@store.name}."
  end
end 