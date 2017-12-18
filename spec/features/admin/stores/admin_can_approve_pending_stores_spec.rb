require 'rails_helper'

RSpec.feature 'Admin views list of stores' do
  context 'As an authenticated admin' do
    it "I can see a list of stores divided into sections" do
      admin = create(:user)
      role = Role.create(name: "admin")
      user_role = UserRole.create(user: admin, role: role)

      store_one = create(:store, user: admin, status: 'pending')
      store_two = create(:store, user: admin, status: 'active')
      store_three = create(:store, user: admin, status: 'suspended')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/dashboard'

      click_on 'Stores'

      expect(page).to have_content('View Pending')
      expect(page).to have_content(store_one.name)
      expect(page).to have_content('View Active')
      expect(page).to have_content('View Suspended')
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