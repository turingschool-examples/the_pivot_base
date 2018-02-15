require 'rails_helper'

RSpec.feature "Authenticated users security" do
  context "As a logged in user" do
    scenario "I cannot view another user's order" do
      chino = create(:registered_user, first_name: "Chino")
      khaki = create(:registered_user, first_name: "Khaki")
      stub_logged_in_user(khaki)

      order = Order.create(user: chino, status: 1)

      expect {
        visit order_path(order)
      }.to raise_error(ActionController::RoutingError)
    end

    it "I cannot view the platform administrator screens" do
      user = create(:registered_user)
      stub_logged_in_user(user)

      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end

    it "I cannot view the business admin screens" do
      user = create(:registered_user)
      store = create(:store)
      store_admin = create(:store_admin, store: store)

      stub_logged_in_user(user)

      expect {
        visit admin_store_dashboard_index_path(store)
      }.to raise_error(ActionController::RoutingError)
    end

  end
end
