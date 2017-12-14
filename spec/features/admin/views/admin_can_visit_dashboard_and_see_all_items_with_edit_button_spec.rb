require 'rails_helper'

RSpec.describe 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      admin_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
      category = create(:category, title: 'Cats')
      store = create(:store, user: admin_user)
      @item_one = create(:item, category_id: category.id, store: store)
      @item_two = create(:item, category_id: category.id, store: store)

      visit store_items_path(store)

      expect(page).to have_content(@item_one.title)
      expect(page).to have_content(@item_one.price)
      expect(page).to have_content(@item_two.title)
      expect(page).to have_content(@item_two.price)
    end
  end
end
