require 'rails_helper'

feature 'a Store manager can edit an item' do
  before(:all) do
    @business_manager = create(:store_manager_with_store_item)
  end

  context "As an authenticated store admin" do
    it 'I can edit an item' do

      login_user(@business_manager.email, @business_manager.password)

      visit admin_store_path(@business_manager.stores.first.url)
      click_on "See all Items"

      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"


      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
      expect(current_path).to eq("/admin/#{@business_manager.stores.first.url}/white-cat-twosie")
    end
  end
end
