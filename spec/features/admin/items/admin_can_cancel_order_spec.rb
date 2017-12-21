require 'rails_helper'

RSpec.feature "admin can cancel order" do
  it "and have it refund the order" do
    user = create(:user)
    user.roles << Role.new(name: "platform admin")
    order = create(:order, status: "paid")
    stripe_service = StripeService.new(user: user, order: order)
    stripe_service.create_charge(amount: 4000,
                                 currency: "usd",
                                 number: "4242-4242-4242-4242",
                                 expiration_date: "12/18",
                                 cvc: "314")
    stub_logged_in_user(user)

    visit "/admin/dashboard"
    click_on "Cancel", match: :first

    updated_order = Order.find(order.id)

    expect(updated_order.status).to eq("cancelled")
    expect(updated_order.charge).to be_falsy
  end
end

