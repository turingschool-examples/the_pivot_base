

#Need to change all instances of admin to manager

require 'rails_helper'

RSpec.feature "Store Manager item creation" do
  context "As an authenticated store manager" do
    it "I can create an item" do
      store = create(:store)
      manager = create(:store_manager, store: store)
      role = Role.create(title: "store_manager")
      create(:user_role, user: manager, role: role)
      create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)

      visit admin_store_items_path(store)
      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Submit"

      expect(current_path).to eq(admin_store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      store = create(:store)
      manager = create(:store_manager, store: store)
      role = Role.create(title: "store_manager")
      create(:user_role, user: manager, role: role)
      category = create(:category)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)
      visit admin_store_items_path(store)

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Submit"

      expect(current_path).to eq(admin_store_items_path(store))
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
