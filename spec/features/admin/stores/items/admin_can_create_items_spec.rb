require 'rails_helper'

feature " Store Admin can create an item" do
  before(:each) do
    @admin = create(:store_admin_with_store_item)
  end

  context "As an authenticated store admin" do
    it "I can create an item" do
      login_user(@admin.email, @admin.password)

      visit admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))

      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))

      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      login_user(@admin.email, @admin.password)

      visit admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
feature "Platform Admin can create an item" do
  before(:each) do
    @platform_admin = create(:platform_admin_with_store_item)
  end

  context "As an authenticated platform_admin admin" do
    it "I can create an item" do
      login_user(@platform_admin.email, @platform_admin.password)

      visit admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@platform_admin.stores.first.url))

      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(@platform_admin.stores.first.url))

      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      login_user(@platform_admin.email, @platform_admin.password)

      visit admin_store_path(@platform_admin.stores.first.url)
      click_on "See all Items"

      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(@platform_admin.stores.first.url))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
feature "Business Manager cannot create an item" do
  before(:each) do
    @business_manager = create(:store_manager_with_store_item)
  end

  context "As an authenticated business manager" do
    it "I cannot create an item" do
      login_user(@business_manager.email, @business_manager.password)

      visit admin_store_path(@business_manager.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@business_manager.stores.first.url))

      expect(page).to_not have_content("Create New Item")
    end
  end
end
