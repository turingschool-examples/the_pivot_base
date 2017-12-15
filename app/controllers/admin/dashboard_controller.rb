class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @orders = Order.get_orders_by_status(params[:status])

    flash[:notice] = "You're logged in as an Administrator."
  end
end
