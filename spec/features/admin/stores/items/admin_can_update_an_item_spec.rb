require 'rails_helper'

feature 'a Store admin can edit an item' do
  before(:all) do
    @admin = create(:store_admin_with_store_item)
  end

  context "As an authenticated store admin" do
    it 'I can edit an item' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"


      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
      expect(current_path).to eq("/admin/#{@admin.stores.first.url}/white-cat-twosie")
    end
  end
end
feature 'a platform admin can edit an item' do
  before(:all) do
    @platform_admin = create(:platform_admin_with_store_item)
  end

  context "As an authenticated platform admin" do
    it 'I can edit an item' do

      login_user(@platform_admin.email, @platform_admin.password)

      visit  admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"

      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"


      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
      expect(current_path).to eq("/admin/#{@platform_admin.stores.first.url}/white-cat-twosie")
    end
  end
end

feature 'a store manager can edit an item' do
  before(:all) do
    @store_manager = create(:store_manager_with_store_item)
  end

  context "As an authenticated platform admin" do
    it 'I can edit an item' do

      login_user(@store_manager.email, @store_manager.password)

      visit  admin_store_path(@store_manager.stores.first.url)
      click_on "See all Items"

      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"


      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
      expect(current_path).to eq("/admin/#{@store_manager.stores.first.url}/white-cat-twosie")
    end
  end
end
