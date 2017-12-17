require 'rails_helper'

feature 'a Store admin can delete an item' do
  before(:all) do
    @admin = create(:store_admin_with_store_items)
  end

  context "As an authenticated store admin" do
    it 'I can delete an item' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"

      within ".items" do
        click_link("Delete", :match => :first)
      end
      expect(current_path).to eq(admin_store_items_path(@admin.stores.first.url))
      expect(@admin.stores.first.items.count).to eq(3)
    end
  end
end
