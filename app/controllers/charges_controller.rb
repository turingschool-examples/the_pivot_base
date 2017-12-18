class ChargesController < ApplicationController
  before_action :amount_to_be_charged

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail],
                                          stripe_token: params[:stripeToken])
    charge = StripeTool.create_charge(customer_id: customer.id,
                                      amount: @amount,
                                      description: @description)

    order = Order.create(status: "paid", user_id: current_user.id)
    item_hash = @cart.cart_items
    item_hash.each do |item, quantity|
      order.order_items.create(quantity: quantity, unit_price: item.price, item: item)
    end
    @cart.destroy
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private


  def amount_to_be_charged
    @amount = params[:amount]
  end

  def description
    @description = "Placeholder description"
  end
end
