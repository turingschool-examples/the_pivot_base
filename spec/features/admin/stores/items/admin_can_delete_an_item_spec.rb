require 'rails_helper'

feature 'a Store admin can delete an item' do
  before(:each) do
    @admin = create(:store_admin_with_store_items)
  end

  context "As an authenticated store admin" do
    it 'I can delete an item' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      within ".items" do
        click_link("Delete", :match => :first)
      end
      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(@admin.stores.first.items.count).to eq(3)
    end
  end
end

feature 'A Platform admin can delete an item' do
  before(:each) do
    @platform_admin = create(:platform_admin_with_store_items)
  end

  context "As an authenticated platform_admin" do
    it 'I can delete an item' do

      login_user(@platform_admin.email, @platform_admin.password)

      visit admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"

      within ".items" do
        click_link("Delete", :match => :first)
      end
      expect(current_path).to eq(admin_store_items_path(@platform_admin.stores.first.url))
      expect(@platform_admin.stores.first.items.count).to eq(3)
    end
  end
end
feature 'A business manager cannot delete an item' do
  before(:each) do
    @store_manager = create(:store_manager_with_store_items)
  end

  context "As an authenticated business manager" do
    it 'I cannot delete an item' do

      login_user(@store_manager.email, @store_manager.password)

      visit admin_store_path(@store_manager.stores.first.url)
      click_on "See all Items"

    expect(page).to_not have_content("Delete")
    end
  end
end
