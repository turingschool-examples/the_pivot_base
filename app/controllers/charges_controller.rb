class ChargesController < ApplicationController
  before_action :amount_to_be_charged

  def new
  end

  def create
    create_charge_and_customer
    create_order
    redirect_to orders_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    def create_charge_and_customer
      @customer = StripeTool.create_customer(email: params[:stripeEmail],
                                            stripe_token: params[:stripeToken])
      @charge = StripeTool.create_charge(customer_id: @customer.id,
                                        amount: @amount,
                                        description: @description)
      current_user.update!(stripe_token: params[:stripeToken], stripe_customer_id: @customer.id)
    end

    def create_order
      order = Order.create(status: "paid", user_id: current_user.id)
      item_hash = @cart.cart_items
      item_hash.each do |item, quantity|
        order.order_items.create(quantity: quantity, unit_price: item.price, item: item)
      end
      @cart.destroy
      flash[:success] = "Order was successfully placed"
    end

    def amount_to_be_charged
      @amount = params[:amount]
    end

    def description
      @description = "Placeholder description"
    end
end
