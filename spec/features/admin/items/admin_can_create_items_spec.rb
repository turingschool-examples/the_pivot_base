require 'rails_helper'

RSpec.feature "Admin item creation" do
  context "As an authenticated admin" do
    it "I can create an item" do
      admin = create(:admin)
			store = create(:store, user: admin)
      create(:item, store: store)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit store_items_path(store)
      click_link "Create New Item"

      expect(current_path).to eq(new_store_item_path(store))

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      admin = create(:admin)
      category = create(:category)
      store = create(:store, user: admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit store_items_path(store)

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
