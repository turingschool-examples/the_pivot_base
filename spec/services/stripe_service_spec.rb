require 'rails_helper'

RSpec.describe StripeService do
  context "class methods" do
    it "#create_or_find_customer" do
      user = create(:user)
      stripe_service = StripeService.new(user: user)
      customer_object_1 = stripe_service.create_or_find_customer
      customer_id_1 = User.find(user.id).customer_id

      expect(customer_object_1).to be_instance_of(Stripe::Customer)
      expect(customer_id_1).to_not be(nil)

      customer_object_2 = stripe_service.create_or_find_customer
      customer_id_2 = User.find(user.id).customer_id

      expect(customer_object_2).to eq(customer_object_1)
      expect(customer_id_2).to eq(customer_id_1)
    end
  end

  context "instance methods" do
    it "#create_charge" do
      user = create(:user)
      order = create(:order, user: user)
      stripe_service = StripeService.new(user: user, order: order)
      params = { number: "4242-4242-4242-4242",
                 expiration_date: "12/19",
                 currency: "usd",
                 amount: 4000,
                 cvc: "314"}
      charge = stripe_service.create_charge(params)

      expect(charge).to be_instance_of(Stripe::Charge)
      expect(charge.source.last4).to eq("4242")
      expect(order.charge).to_not be_nil
    end
  end
end
