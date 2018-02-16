require 'rails_helper'


RSpec.describe 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      item = create(:item)
      admin = create(:store_admin)
      user = create(:user)
      store = user.store
      role = create(:role, title: "store_admin")
      create(:user_role, user: user, role: role)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_store_items_path(item.store)
      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Submit"

      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
    end
  end
end
