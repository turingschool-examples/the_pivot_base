class CreditCard < ApplicationRecord
  def self.last4digits(cc, card_num)
    cc.card_number = card_num[-4..-1]
    cc.save!
  end
end
