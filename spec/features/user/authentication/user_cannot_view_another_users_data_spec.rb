require 'rails_helper'

RSpec.feature "Authenticated users security" do
  context "As a logged in user" do

    scenario "I cannot view another user's order" do
      chino = create(:user, first_name: "Chino")
      khaki = create(:user, first_name: "Khaki")
      stub_logged_in_user(khaki)

      order = create(:order, user: chino)

      expect {
       visit order_path(order)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "I cannot view the administrator screens" do
      user = create(:user)
      stub_logged_in_user(user)

      visit "/admin/dashboard"
      expect(page).to have_content ("The page you were looking for doesn't exist")
    end
  end
end
