class Charge < ApplicationRecord
  belongs_to :order

  def refund
    self.transaction do
      StripeService.refund_charge(self)
      destroy!
    end
  end

end
