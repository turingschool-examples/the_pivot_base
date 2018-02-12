
require 'rails_helper'

RSpec.feature "Unauthenticated users security" do

  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      user = User.new(first_name: "user")
      item_1 = create(:item)
      item_2 = create(:item)
      order_1 = Order.create(user: user, status: 1)

      visit dashboard_index_path
      expect(current_path).to eq(login_path)

      expect {
        visit order_path(order_1)
      }.to raise_exception(ActionController::RoutingError)

    end

    it "I should be redirected to login/create account when I try to check out" do
      store = create(:store)
      item_1 = create(:item, store: store)

      visit store_item_path(store, item_1)
      click_on "Add to cart"
      click_on "Cart"
      expect(page).to_not have_content("Checkout")
      expect(page).to have_content("Login")
      expect(page).to have_content("Create new account")

      expect {
        visit new_order_path
      }.to raise_exception(ActionController::RoutingError)

    end

  end
end
