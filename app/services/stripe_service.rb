class StripeService

  def initialize(params={})
    @user = params[:user]
    @order = params[:order]
    @@api_key = "sk_test_rAC4lga59LbT3nlkw2tQb9Z2"
    Stripe.api_key ||= @@api_key
  end

  def create_or_find_customer
    if !user.customer_id
      customer = Stripe::Customer.create(email: user.email)
      user.customer_id = customer.id
      user.save!(validate: false)
      return customer
    else
      Stripe::Customer.retrieve(user.customer_id)
    end
  end

  def sources
    customer = create_or_find_customer
    customer.sources.data
  end

  def create_charge(params)
    customer = create_or_find_customer
    token = initialize_token(customer, params)
    charge = Stripe::Charge.create(amount: params[:amount],    
                          currency: params[:currency],
                          description: "Charge for #{user.email} at #{Time.now}",
                          source: token.id,
                          customer: customer.id )
    order.create_charge(charge_id: charge.id) if order
    return charge
  end

  def self.refund_charge(charge, amount=nil)
    Stripe::Refund.create(charge: charge.charge_id,
                          amount: amount)
  end


  private
    attr_reader :user,
                :order

    def create_token(customer, params)
      customer.sources.create(card: {
        number: params[:number].gsub(/[^0-9,.]/, ""),
        exp_month: params[:expiration_date][0..1],
        exp_year: "20" + params[:expiration_date][-2..-1],
        cvc: params[:cvc]})
    end

    def get_previous_card(card_last_4)
      sources.find { |card| card.last4 == card_last_4 }
    end

    def initialize_token(customer, params)
      if params[:previous_card]
        get_previous_card(params[:previous_card])
      else
        create_token(customer, params)  
      end
    end

end
