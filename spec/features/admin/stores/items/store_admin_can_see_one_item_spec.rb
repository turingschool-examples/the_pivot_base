require 'rails_helper'

feature 'a Store admin can view an item show page' do
  before(:all) do
    @admin = create(:store_admin_with_store_item)
  end

  context "As an authenticated store admin" do
    it 'I can see an item show page' do

      login_user(@admin.email, @admin.password)

      visit  admin_store_path(@admin.stores.first.url)
      click_on "See all Items"


      within ".items" do
        click_link("#{@admin.stores.first.items.first.title}", :match => :first)
      end

      expect(current_path).to eq(admin_store_item_path(@admin.stores.first.url, @admin.stores.first.items.first.url))
      expect(page).to have_content(@admin.stores.first.items.first.title)
      expect(page).to have_content(@admin.stores.first.items.first.description)
      expect(@admin.stores.first.items.count).to eq(1)
    end
  end
end
