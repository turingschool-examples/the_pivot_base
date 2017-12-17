class Admin::DashboardController < ApplicationController
before_action :require_admin
  def index
    @admin = User.find(current_user.id)
    @orders = Order.all
  end

private
  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
