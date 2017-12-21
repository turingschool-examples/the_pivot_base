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
    fast_checkout if params[:fast] 
  end

  def create
    format_amount
    begin
      current_user.create_charge(stripe_params)
      flash[:message] = "Order successfully placed"
      @cart.destroy
      redirect_to orders_path
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
    params.permit(:number, :expiration_date, :previous_card, :cvc, :amount, :currency)
  end

  def format_amount
    params[:amount] = (params[:amount].to_f * 100).to_i
  end

  def fast_checkout
    params[:currency] = "usd"
    params[:amount] = @order.total_price
    create
  end

end
