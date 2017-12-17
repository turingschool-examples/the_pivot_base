require 'rails_helper'

feature 'a Store admin can visit admin dashboard' do


      before(:all) do
        @admin = create(:user)
        role = create(:role, name: "store_admin")
        @store = create(:store)
        items = create_list(:item, 4)
        @store.items << items
         create(:store_user, user: @admin, role: role, store: @store)
      end

      context 'and see a link for all items assocatiated to by store' do
      it 'when clicked that link should be the admin item index with admin functionality' do

      visit  admin_store_path(@store.url)
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
