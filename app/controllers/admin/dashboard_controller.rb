class Admin::DashboardController < ApplicationController
before_action :require_admin
  def index
    @admin = User.find(current_user.id)
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.all
    end
    flash[:notice] = "You're logged in as an Administrator"
  end

private
  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
