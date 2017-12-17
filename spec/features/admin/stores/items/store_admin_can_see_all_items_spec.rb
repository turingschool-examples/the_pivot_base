require 'rails_helper'

feature 'a Store admin can see all items associated with a store' do
  before(:all) do
    @admin = create(:store_admin_with_store_items)
  end

  context "As an authenticated store admin" do
    it 'I can see all items for the store' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(page).to have_content(@admin.stores.first.items.first.title)
      expect(page).to have_content(@admin.stores.first.items.first.description)
      expect(@admin.stores.first.items.count).to eq(4)
    end
  end
end
