class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.all
    end
    @order_presenter = OrderPresenter.new
  end
end
