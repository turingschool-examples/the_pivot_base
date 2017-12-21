class StripeService

  def initialize(params={})
    @user = params[:user]
    @@api_key = "sk_test_rAC4lga59LbT3nlkw2tQb9Z2"
    Stripe.api_key ||= @@api_key
  end

  def create_or_find_customer
    if !user.uid
      customer = Stripe::Customer.create(email: user.email)
      user.update!(uid: customer.id)
      return customer
    else
      Stripe::Customer.retrieve(user.uid)
    end
  end

  def sources
    customer = create_or_find_customer
    customer.sources.data
  end

  def create_charge(params)
    customer = create_or_find_customer
    if token = create_token(customer, params) 
      Stripe::Charge.create(amount: params[:amount],    
                            currency: params[:currency],
                            description: "Charge for #{user.email} at #{Time.now}",
                            customer: customer )
    end
  end

  private
    attr_reader :user

    def create_token(customer, params)
      customer.sources.create(card: {
        number: params[:number].gsub(/[^0-9,.]/, ""),
        exp_month: params[:expiration_date][0..1],
        exp_year: "20" + params[:expiration_date][-2..-1],
        cvc: params[:cvc]})
    end

end
