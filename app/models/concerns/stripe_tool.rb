module StripeTool
  def self.create_customer(email: email, stripe_token: stripe_token)
    Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def self.create_charge(customer_id: customer_id, amount: amount, description: description)
    Stripe::Charge.create(
      customer: customer_id,
      amount: amount,
      description: description,
      currency: 'usd'
    )
  end

  def self.add_new_credit_card(stripe_customer_id, stripe_token, number, name,
                               city, country, address_one, address_two=nil,
                               state, zip, exp_month, exp_year, cvv)
    customer = Stripe::Customer.retrieve(stripe_customer_id)
    card = customer.sources.retrieve(stripe_token)
    customer.sources.create({
    :card => {
     :number => number,
     :exp_month => exp_month,
     :exp_year => exp_year,
     :cvc => cvv,
     :name => name,
     :address_line1 => address_one,
     :address_line2 => address_two,
     :address_city => city,
     :address_zip => zip,
     :address_state => state,
     :address_country => country
  }
})
    card.save
  end
end
