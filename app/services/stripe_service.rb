class StripeService

  def initialize(params={})
    @credit_card_number = params[:credit_card_number]
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @cvc = params[:cvc]
    @amount = params[:amount]
    @email = params[:email]
    @@api_key ||= ENV['STRIPE_API_KEY']
    Stripe.api_key ||= @@api_key
  end

  def process_payment
    begin
      #token = create_token
      charge = create_charge
    rescue Stripe::InvalidRequestError => e
      e.message
    rescue => e
      binding.pry
      e.message
    #rescue
      #"Something went wrong with your transaction, please try again later"
    end
  end

  private
    attr_reader :credit_card_number,
                :credit_card_expiration_date,
                :cvc,
                :amount,
                :email

    def create_token
      Stripe::Token.create(card: {
        number: credit_card_number,
        month: credit_card_expiration_date[0..1],
        year: "20" + credit_card_expiration_date[-2..-1],
        cvc: cvc })
    end 

    def create_charge
      Stripe::Charge.create(amount: amount,
                            currency: 'usd',
                            source: "tok_amex",
                            description: "Charge for #{email} on #{Time.now}")
    end

end
