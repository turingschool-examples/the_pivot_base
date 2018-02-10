#need to update the /items path to be show/items_path

#need to update the test objects to have a store

require 'rails_helper'

RSpec.feature "Unauthenticated users security" do

  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      order = create(:order)
      visit dashboard_index_path

      expect(current_path).to eq(login_path)

      visit order_path(order)

      expect(current_path).to eq(login_path)
    end

    it "I should be redirected to login/create account when I try to check out" do
      unicorn_onesie_1 = create(:item)

      visit item_path(unicorn_onesie_1)

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to_not have_content("Checkout")

      visit new_order_path

      expect(current_path).to eq(login_path)
    end

    xit "I cannot view the platform_admin's pages" do
      expect {
        visit platform_admin_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end

    xit "I cannot view the business admin's pages" do
      expect {
        visit business_admin_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end

    xit "I cannot view the business manager's pages" do
      expect {
        visit business_manager_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end
  end
end
