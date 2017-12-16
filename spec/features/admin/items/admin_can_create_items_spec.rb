require 'rails_helper'

feature " Store Admin can create an item" do
  before(:all) do
    # @admin = create(:user_roles).store_admin
    @admin = create(:user)
    role = create(:role, name: "store_admin")
    store = create(:store)
    # item = create(:item)
    create(:user_role, user: @admin, role: role, store: store)
    # create(:store_item, item: item, store: store)
  end
  context "As an authenticated store admin" do
    it "I can create an item" do
      # admin = build(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit store_path
      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(store_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do

      category = create(:category)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit store_path

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
