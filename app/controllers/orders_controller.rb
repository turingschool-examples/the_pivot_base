class OrdersController < ApplicationController
  # before_action :require_current_user

  def index
    @user = current_user
    @user.orders.preload(:items)
  end

  def show
    if current_store_admin? || current_store_manager?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def update
    if current_store_admin? || current_store_manager? || current_platform_admin?
      @order = Order.find(params[:id])
      @order.update(order_params)
      @order.save
    else
      @order = current_user.orders.find(params[:id])
      @order.update(order_params)
      @order.save
    end

    redirect_back(fallback_location: root_path)
  end


  def new
    order = current_user.orders.new
    order.create_order_with_associations(current_user, @cart)
    @cart.destroy
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  end

  private

    def require_current_user
      redirect_to login_path unless current_user
    end

    def order_params
      params.permit(:status, :user_id)
    end

end
