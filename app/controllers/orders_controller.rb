class OrdersController < ApplicationController
  before_action :require_current_user

  def index
    @user = current_user
    @user.orders.preload(:items)
  end

  def show
    if current_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.save
    redirect_back(fallback_location: root_path)
  end

  def new
    @order = Order.new(status: "ordered", user: current_user)
    item_hash = @cart.cart_items
    @order.add(item_hash)
  end

  def create
    begin
      order = current_user.orders.new(status: "ordered")
      order.add(@cart.cart_items)
      stripe_service = StripeService.new(stripe_params.merge(order: order, amount: order.total_price))
      if stripe_service.process_payment
        flash[:message] = "Order successfully placed"
        @cart.destroy
        redirect_to orders_path
      else
        redirect_to new_order_path
      end
    rescue Exception => e
      flash[:message] = e.message
      redirect_to new_order_path
    end
  end

  private

  def require_current_user
    redirect_to login_path unless current_user
  end

  def order_params
    params.permit(:status, :user_id)
  end

  def stripe_params
    params.permit(:credit_card_number, :credit_card_expiration_date, :CCV)
  end

end
