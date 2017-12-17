require 'rails_helper'

describe 'an admin can visit admin dashboard' do
  let!(:role)             {create(:role, name: 'platform admin')}
  let!(:admin)            {create(:user, email: "admin@example.com")}
  let!(:user_role_store)  {create(:user_role_store, user: admin, role: role)}
  let!(:item)             {create(:item)}

  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      stub_logged_in_user(admin)

      visit admin_items_path

      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"

      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
    end
  end
end
