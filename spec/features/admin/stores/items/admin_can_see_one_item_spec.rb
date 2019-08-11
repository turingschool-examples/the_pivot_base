require 'rails_helper'

feature 'a Store admin can view an item show page' do
  before(:each) do
    @admin = create(:store_admin_with_store_item)
  end

  context "As an authenticated store admin" do
    it 'I can see an item show page' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"


      within ".items" do
        click_link("#{@admin.stores.first.items.first.title}", :match => :first)
      end

      expect(current_path).to eq(admin_store_item_path(@admin.stores.first.url, @admin.stores.first.items.first.url))
      expect(page).to have_content(@admin.stores.first.items.first.title)
      expect(page).to have_content(@admin.stores.first.items.first.description)
      expect(@admin.stores.first.items.count).to eq(1)
    end
  end
end
feature 'a platform admin can view an item show page' do
  before(:each) do
    @platform_admin = create(:platform_admin_with_store_item)
  end

  context "As an authenticated platform admin" do
    it 'I can see an item show page' do

      login_user(@platform_admin.email, @platform_admin.password)

      visit  admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"


      within ".items" do
        click_link("#{@platform_admin.stores.first.items.first.title}", :match => :first)
      end

      expect(current_path).to eq(admin_store_item_path(@platform_admin.stores.first.url, @platform_admin.stores.first.items.first.url))
      expect(page).to have_content(@platform_admin.stores.first.items.first.title)
      expect(page).to have_content(@platform_admin.stores.first.items.first.description)
      expect(@platform_admin.stores.first.items.count).to eq(1)
    end
  end
end
feature 'a Store manager can view an item show page' do
  before(:each) do
    @store_manager = create(:store_manager_with_store_item)
  end

  context "As an authenticated store manager" do
    it 'I can see an item show page' do

      login_user(@store_manager.email, @store_manager.password)

      visit  admin_store_path(@store_manager.stores.first.url)
      click_on "See all Items"


      within ".items" do
        click_link("#{@store_manager.stores.first.items.first.title}", :match => :first)
      end

      expect(current_path).to eq(admin_store_item_path(@store_manager.stores.first.url, @store_manager.stores.first.items.first.url))
      expect(page).to have_content(@store_manager.stores.first.items.first.title)
      expect(page).to have_content(@store_manager.stores.first.items.first.description)
      expect(@store_manager.stores.first.items.count).to eq(1)
    end
  end
end
