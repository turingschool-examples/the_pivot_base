class Admin::DashboardController < ApplicationController

  def index
    if params[:status] == "ordered" || params[:status] == "paid" || params[:status] == "cancelled" || params[:status] == "completed"
      @orders = Order.filter_by_status(params[:status])
    else
      @orders = Order.all
    end
    flash[:notice] = "You're logged in as an Administrator."
  end
end
