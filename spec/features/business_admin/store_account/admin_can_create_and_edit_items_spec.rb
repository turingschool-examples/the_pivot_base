#need to change paths and test data

require 'rails_helper'

RSpec.feature "Admin item creation" do
  context "As an authenticated admin" do
    xit "I can create an item" do
      admin = build(:admin)
      store = admin.store
      create(:category)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_store_items_path(store)

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    xit "I can create an item without an image and it defaults" do
      admin = build(:admin)
      store = admin.store
      category = create(:category)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_store_items_path(store)

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(admin_store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    xit "I can edit an item" do
      # When store admin visits '/admin/items'
      # they can edit items
      # they can activate/deactivate items
    end


  end
end
