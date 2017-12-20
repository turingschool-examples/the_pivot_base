require 'rails_helper'

RSpec.describe StripeService do
  context "class methods" do
    it "#create_or_find_customer" do
      user = create(:user)
      customer_object = StripeService.create_or_find_customer(user)
      uid_1 = User.find(user.id).uid

      expect(customer_object_1).to be_instance_of(Stripe::Customer)
      expect(uid_1).to_not be(nil)

      customer_object_2 = StripeService.create_or_find_customer(user)
      uid_2 = User.find(user.id).uid

      expect(customer_object_2).to eq(customer_object_1)
      expect(uid_2).to eq(uid_1)
    end
  end

  context "instance methods" do
    it "#create_charge" do
      user = create(:user)
      customer_object = StripeService.create_or_find_customer(user)
      stripe_service = StripeService.new(user)
      params = { number: "123456",
                 expiration_date: "12/34",
                 amount: 4000,
                 cvc: "123"}
      charge = stripe_service.create_charge(params)
      final_customer_object = StripeService.create_or_find_customer(user)

      expect(charge).to be_instance_of(Stripe::Charge)
      expect(final_customer_object.sources.count).to eq(1)
      expect(final_customer_object.sources[0].last_4).to eq("3456")
    end
  end
end
