class CreditCard < ApplicationRecord
  def save_credit_card_details(last4digits, expiration_month, expiration_year)
    self.last4digits = last4digits
    self.expiration_month = expiration_month
    self.expiration_year = expiration_year
    self.save!
  end
end
