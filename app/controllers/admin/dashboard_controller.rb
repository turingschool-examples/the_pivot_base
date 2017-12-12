class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    if params[:status]
      @orders = Order.filter_by_status(params[:status])
    else
      @orders = Order.all
    end
    @order_presenter = OrderPresenter.new
    flash[:notice] = "You're logged in as an Administrator."
  end
end
