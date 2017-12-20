class StripeService

  def initialize(params={})
    @user = params[:user]
    @@api_key = ENV['STRIPE_API_KEY'] || "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
    Stripe.api_key ||= @@api_key
  end

  def process_payment
    charge = JSON.parse(create_charge.to_json)
    if charge["id"]
      order.update!(status: "paid")
      order.create_charge(uid: charge["id"], credit_card_number: credit_card_number)
    else
      return false
    end
  end

  def self.create_or_find_customer(params)
    user = params[:user]
    if !user.uid
      Stripe::Customer.create(email: email)
    else
      Stripe::Customer.retreive(user.uid)
    end
  end

  def create_charge(params)
    customer = retreive_customer
    if token = create_token(params) 
      Stripe::Charge.create(card: {
        amount: params[:amount],    
        currency: "usd",
        source: token.id,
        description: "Charge for #{user.email} at #{Time.now}"})
      user.cards.create(uid: token.id)
    end
  end

  private
    attr_reader :user

    def retrieve_customer
      Stripe::Customer.retrieve(user.uid)
    end

    def create_token(params)
      Stripe::Token.create(card: {
        number: params[:number],
        exp_month: params[:expiration_date][0..1],
        exp_year: "20" + params[:expiration_date][-2..-1],
        cvc: params[:cvc]})
    end

end
