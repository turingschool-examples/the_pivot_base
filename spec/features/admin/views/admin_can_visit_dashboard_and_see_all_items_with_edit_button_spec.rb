require 'rails_helper'

RSpec.describe 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do

    let!(:role)             {create(:role, name: 'platform admin')}
    let!(:admin)            {create(:user, email: "admin@example.com")}
    let!(:user_role_store)  {create(:user_role_store, user: admin, role: role)}
    it 'when clicked that link should be the admin item index with admin functionality' do
      stub_logged_in_user(admin)

      item_one, item_two = create_list(:item, 2, category: create(:category))

      visit admin_dashboard_index_path

      click_on "View Items"

      expect(page).to have_content(item_one.title)
      expect(page).to have_content(item_one.price)
      expect(page).to have_content(item_two.title)
      expect(page).to have_content(item_two.price)
      expect(page).to have_content("Edit")
    end
  end
end
