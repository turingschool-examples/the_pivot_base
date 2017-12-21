require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do
    user = create(:user)
    store = create(:store, status: 2)
    create(:item, category: create(:category), store: store)

    visit "/#{store.slug}"
    click_on "Add to cart"
    visit cart_path

    within(".checkout") do
      click_on("Login")
    end

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    within(".action") do
      click_on("Login")
    end

    click_on "Cart"

    expect(page).to have_content("Checkout")

    click_on "Checkout"

    expect(current_path).to eq('/orders/new')
    
    fill_in "number", with: "4242-4242-4242-4242"
    fill_in "expiration_date", with: "12/19"
    fill_in "cvc", with: "314"
    click_on "Place Order"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order successfully placed")
    expect(Charge.first).to_not be_nil
  end
end
