class Admin::Stores::DashboardController < ApplicationController
  # before_action :require_admin


  def index
    @store = Store.find_by(slug: params[:store])
    if params[:status]
      @orders = @store.orders.filter_by_status(params[:status])
    else
      @orders = Order.
    end
    flash[:notice] = "You're logged in as an Administrator."
  end

# private
#   def require_admin
#     render file: "/public/404" unless current_store_admin?
#   end
end
