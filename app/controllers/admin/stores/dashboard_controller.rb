class Admin::Stores::DashboardController < ApplicationController

  def index
    @store = Store.find_by(slug: params[:store])


    if params[:status]
      #fix me
      @orders = Order.filter_by_status(params[:status])
    else
      @orders = Order.all
    end

    flash[:notice] = "You're logged in as an Administrator."
  end


end
