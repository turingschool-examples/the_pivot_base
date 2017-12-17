require 'rails_helper'

RSpec.describe StripeService do
  context "making a payment" do
    it "#process payment" do
      order = create(:order)
      StripeService.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
      stripe_service = StripeService.new(credit_card_number: "12345", credit_card_expiration_date: "12/34", cvc: "123", amount: 2000, email: "liam@liambarstad.com", order: order)
      result = stripe_service.process_payment
      charge = order.charge

      expect(result).to be_truthy
      expect(order.status).to eq("paid")
      expect(charge).to be_instance_of(Charge)
    end

  end
end
