require 'rails_helper'

RSpec.feature "As a Platform admin " do
  describe "When I visit admin/dashboard" do
    let!(:admin)     { create(:platform_admin) }
    let!(:pending)   { create(:store) }
    let!(:suspended) { create(:store, status: 1) }
    let!(:active)    { create(:store, status: 2) }

    before { login_user(admin.email, admin.password) }

    it "I see a link called stores" do
      expect(current_path).to eq('/admin/dashboard')

      click_on "Stores"

      expect(page).to have_content(pending.name)
      expect(page).to have_content(suspended.name)
      expect(page).to have_content(active.name)

    end
  end
end

# Background: 3 stores: (Vandelay Industries - pending), (Innotech - suspended), (Bluth Company - active)

# As an admin
# When I visit "/admin/dashboard"
# And I click "Stores"
# Then I should see a list of stores divided into sections by their status
# And "pending" should be the first tab
# And "active" should be the second tab
# And "suspended" should be the last tab
# And when I click "Approve" for the pending company
# Then it shows up in the "active" tab

# NOTE: There should be no option to delete stores. We want to maintain records of all stores even if they shut down.