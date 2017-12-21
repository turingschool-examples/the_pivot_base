require 'rails_helper'

RSpec.feature "user can checkout" do
  it "with saved credit card" do
    user = create(:user)
    stub_logged_in_user(user)
    item1, item2, item3 = create_list(:item, 3)
    stripe_service = StripeService.new(user: user)
    params = { number: "4242-4242-4242-4242",
               expiration_date: "12/19",
               currency: "usd",
               amount: 4000,
               cvc: "314" }
    stripe_service.create_charge(params)

    visit "/"
    click_on "Add to cart", match: :first
    click_on "Cart"
    click_on "Checkout"
    
    expect(page).to have_content("4242")

    select "4242", from: "previous_card"

    click_on "Place Order"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order successfully placed")
  end
end
