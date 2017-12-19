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

  def self.add_new_credit_card(stripe_customer_id, stripe_token)
    run_with_stripe_exception_handler('Add a new credit card failed due to') do
      customer = Stripe::Customer.retrieve(stripe_customer_id)
      card = customer.cards.create(card: stripe_token)
      card.save
      customer.default_card = card.id
      customer.save
      card
    end
  end

  def self.add_card(customer_id, token)
    customer = Stripe::Customer.retrieve(customer_id)
    customer.sources.create(source: token)
  end
end
