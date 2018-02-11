class Admin::Stores::DashboardController < ApplicationController
  # before_action :require_admin


  def index
    @items = Item.all
    @stores = Store.all
    if params[:status]
      @orders = orders where the order_item table has a store id of @store.id
      # @orders = @store.orders.filter_by_status(params[:status])
    else
      @orders = 
    end

    flash[:notice] = "You're logged in as an Administrator."
  end

# private
#   def require_admin
#     render file: "/public/404" unless current_store_admin?
#   end
end
