require 'rails_helper'

feature 'a Store admin can see all items associated with a store' do
  before(:each) do
    @admin = create(:store_admin_with_store_items)
  end

  context "As an authenticated store admin" do
    it 'I can see all items for the store' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(page).to have_content(@admin.stores.first.items.first.title)
      expect(page).to have_content(@admin.stores.first.items.first.description)
      expect(@admin.stores.first.items.count).to eq(4)
    end
  end
end
feature 'a Store admin can see all items associated with a store' do
  before(:each) do
    @admin = create(:store_admin_with_store_items)
  end

  context "As an authenticated store admin" do
    it 'I can see all items for the store' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(page).to have_content(@admin.stores.first.items.first.title)
      expect(page).to have_content(@admin.stores.first.items.first.description)
      expect(@admin.stores.first.items.count).to eq(4)
    end
  end
end

feature 'A platform_admin can see all items associated with a store' do
  before(:each) do
    @platform_admin = create(:platform_admin_with_store_items)
  end

  context "As an authenticated platform admin" do
    it 'I can see all items for the store' do

      login_user(@platform_admin.email, @platform_admin.password)

      visit  admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@platform_admin.stores.first.url))
      expect(page).to have_content(@platform_admin.stores.first.items.first.title)
      expect(page).to have_content(@platform_admin.stores.first.items.first.description)
      expect(@platform_admin.stores.first.items.count).to eq(4)
    end
  end
end

feature 'A store manager can see all items associated with a store' do
  before(:each) do
    @store_manager = create(:store_manager_with_store_items)
  end

  context "As an authenticated store manager" do
    it 'I can see all items for the store' do

      login_user(@store_manager.email, @store_manager.password)

      visit  admin_store_path(@store_manager.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@store_manager.stores.first.url))
      expect(page).to have_content(@store_manager.stores.first.items.first.title)
      expect(page).to have_content(@store_manager.stores.first.items.first.description)
      expect(@store_manager.stores.first.items.count).to eq(4)
    end
  end
end
