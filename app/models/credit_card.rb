class CreditCard < ApplicationRecord
  def self.last4digits(user, card_num)
    user = User.find(user.id)
    user.card_number = card_num[-4..-1]
    user.save!
  end
end
