module ChargesHelper
  def pretty_amount(amount_in_cents)
    number_to_currency(amount_in_cents)
  end
end
