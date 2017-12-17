require 'rails_helper'

feature 'a store manager can visit a store show page' do
  let(:admin) {create(:store_manager_with_multiple_stores)}
  let(:store) { admin.stores.first }

  context 'and manage store details' do
    it 'they see all store information' do
      login_user(admin.email, admin.password)
      visit store_manager_dashboard_path
      click_on "#{store.name}"

      expect(current_path).to eq(admin_store_path(store.url))
      expect(page).to have_content(store.name)
      expect(page).to have_content(store.status)
    end

    it 'they see all users associated with that store' do
      user = create(:user)
      role = create(:role, name: "store_admin")
      create(:store_user, user: user, role: role, store: store)
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_content("Store Manager: #{admin.first_name}")
      expect(page).to have_content("Store Administrator: #{user.first_name}")
    end

    it 'they see a link to all store items' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("See All Items for this Store")
    end

    it 'they see a link to all store orders' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("See All Orders for this Store")
    end
  end
end
