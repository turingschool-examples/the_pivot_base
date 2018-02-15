require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do
    user = create(:user, email: "testerson@testmail.com", password: "testing")
    role = create(:role)
    user_role = create(:user_role, user: user, role: role)
    store = create(:store)
    item_one = create(:item, store: store)

    visit store_items_path(store)

    click_on "Add to cart"

    visit cart_path

    within(".checkout") do
      click_on("Login")
    end

    fill_in "session[email]", with: "testerson@testmail.com"
    fill_in "session[password]", with: "testing"

    click_button("Login")

    click_on "Cart"

    expect(page).to have_content("Checkout")

    click_on "Checkout"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order was successfully placed")
  end
end
