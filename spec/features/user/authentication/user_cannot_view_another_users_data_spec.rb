require 'rails_helper'

RSpec.feature "Authenticated users security" do
  user_1, user_2 = create_list(:user, 2)
  order          = create(:order, user: user_2)

  context "As a logged in user" do
    before { stub_logged_in_user(user_1) }
    scenario "I cannot view another user's order" do
      expect {
        visit order_path(order)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "I cannot view the administrator screens" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
