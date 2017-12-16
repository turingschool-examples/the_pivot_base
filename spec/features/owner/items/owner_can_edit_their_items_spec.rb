require 'rails_helper'


RSpec.describe 'an owner can visit owner dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the owner item index with owner functionality' do
      owner = create(:owner)
      store = create(:store, user: owner)
      item = create(:item, store: store)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(owner)

      visit store_items_path(store)
      click_on item.title
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