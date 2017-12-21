require 'rails_helper'

RSpec.feature "Unauthenticated users security" do
  let!(:user_1)    { create(:user) }
  let!(:user_2)    { create(:user) }
  let!(:order)     { create(:order, user: user_1) }
  let!(:cool_item) { create(:item) }

  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      visit dashboard_index_path

      expect(current_path).to eq(login_path)

      visit order_path(order)

      expect(current_path).to eq(login_path)
    end

    it "I should be redirected to login/create account when I try to check out" do
      visit item_path(cool_item)
      click_on "Add to cart"
      click_on "Cart"

      expect(page).to_not have_content("Checkout")

      visit new_order_path

      expect(current_path).to eq(login_path)
    end

    it "I cannot view the administrator screens or use administrator functionality" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end
  end
end
