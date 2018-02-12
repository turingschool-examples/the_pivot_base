class Admin::Stores::DashboardController < ApplicationController



  def index
    @items = Item.all
    @stores = Store.all
    if params[:status]
      @orders = Order.filter_by_status(params[:status])
    else
      @orders = Order.all
    end

    flash[:notice] = "You're logged in as an Administrator."
  end


end
