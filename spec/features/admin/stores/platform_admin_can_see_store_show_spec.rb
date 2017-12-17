require 'rails_helper'

feature 'a platform admin can visit a store show page' do
  let(:admin) {create(:platform_admin)}
  let(:store) { admin.stores.first }

  context 'and manage store details' do
    it 'they see all store information' do
      login_user(admin.email, admin.password)
      visit platform_admin_dashboard_path
      click_on "#{store.name}"

      expect(current_path).to eq(admin_store_path(store.url))
      expect(page).to have_content(store.name)
      expect(page).to have_content(store.status.titleize)
    end

    it 'they see all users associated with that store' do
      user1 = create(:user)
      user2 = create(:user)
      manager_role = create(:role, name: "store_manager")
      admin_role = create(:role, name: "store_admin")
      create(:store_user, user: user1, role: manager_role, store: store)
      create(:store_user, user: user2, role: admin_role, store: store)
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("Add New Store Employee")
      expect(page).to have_content("Store Manager")
      expect(page).to have_content("#{user1.first_name}")
      expect(page).to have_content("Store Admin")
      expect(page).to have_content("#{user2.first_name}")
      expect(page).to have_link("Edit Employee Privileges")
      expect(page).to have_link("Remove Employee")
    end

    it 'they see a link to update store info' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("Update Business Information")
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
