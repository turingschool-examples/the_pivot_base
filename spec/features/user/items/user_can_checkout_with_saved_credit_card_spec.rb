require 'rails_helper'

RSpec.feature "user can checkout" do
  it "with saved credit card" do
    user = create(:user)
    stub_logged_in_user(user)
    item1, item2, item3 = create_list(:item, 3)
    stripe_service = StripeService.new(credit_card_number: "12345",
                      credit_card_expiration_date: "12/34",
                      cvc: "123",
                      amount: 2000,
                      email: "test@notarealemail.com",
                      order: create(:order, user: user))
    stripe_service.process_payment

    visit "/"
    click_on "Add to cart", match: :first
    click_on "Cart"
    click_on "Checkout"
    
    expect(page).to have_content("2345")
  end
end
