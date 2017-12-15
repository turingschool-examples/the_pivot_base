require 'rails_helper'

feature " Store Admin can create an item" do
  before(:all) do
    @admin = create(:user_roles).store_admin
    # @admin = create(:user, email: "store_admin@example.com")
    # role = create(:role, name: "store_admin")
    # store = create(:store)
    # create(:user_role, user: @admin, role: role, store: store)
  end
  context "As an authenticated store admin" do
    it "I can create an item" do
      # admin = build(:admin)
      create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_items_path
      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      admin = build(:admin)
      category = create(:category)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_items_path

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
