require 'rails_helper'

RSpec.describe 'a store admin can visit store admin dashboard' do
  describe 'and see a link for all store items' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      # admin_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", role: "admin")
      store = create(:store)
      admin_user = create(:store_admin, store: store)
      role = Role.create(title: "store_admin")
      create(:user_role, user: admin_user, role: role)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

      # two_items
      @item_one, @item_two = create_list(:item, 2, store: store)

      visit admin_store_dashboard_index_path(store)

      click_on "Items"

      expect(page).to have_content(@item_one.title)
      expect(page).to have_content(@item_one.price)
      expect(page).to have_content(@item_two.title)
      expect(page).to have_content(@item_two.price)
      expect(page).to have_content("Edit")
    end
  end
end
