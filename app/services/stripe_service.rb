class StripeService

  def initialize(params={})
    @credit_card_number = params[:credit_card_number]
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @month = get_month
    @year = get_year
    @cvc = params[:cvc]
    @amount = params[:amount]
    @email = params[:email]
    @@api_key ||= ENV['STRIPE_API_KEY']
    Stripe.api_key ||= @@api_key
  end

  def process_payment
    token = create_token
    charge = create_charge
  end

  private
    attr_reader :credit_card_number,
                :credit_card_expiration_date,
                :cvc,
                :amount,
                :email,
                :month,
                :year

    def create_token
      Stripe::Token.create(card: {
        number: credit_card_number,
        month: month,
        year: year,
        cvc: cvc })
    end 

    def create_charge
      Stripe::Charge.create(amount: amount,
                            currency: 'usd',
                            source: "tok_amex",
                            description: "Charge for #{email} on #{Time.now}")
    end

    def get_month
      if valid_date?
        credit_card_expiration_date[0..1]
      end
    end

    def get_year
      if valid_date?
        "20" + credit_card_expiration_date[-2..-1]
      end
    end

    def valid_date?
      credit_card_expiration_date && credit_card_expiration_date.length > 3
    end

end
