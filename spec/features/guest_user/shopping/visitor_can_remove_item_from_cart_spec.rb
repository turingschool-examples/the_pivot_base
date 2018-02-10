#need to update the /items path to be show/items_path

#need to update the test objects to have a store

require 'rails_helper'

RSpec.feature "Removing an item from my cart" do
  let!(:item) { create(:item, price: 19.99) }

  before do
    visit store_items_path(store)
  end

  describe "When a visitor is viewing their cart" do
    it "they can remove an item" do
      click_on "Add to cart"

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to have_link("Remove")

      click_link("Remove")

      expect(current_path).to eq(carts_path)
      expect(page).to have_content("Successfully removed #{item.title} from your cart.")
      expect(page).to have_link(item.title, href:store_item_path(store, item))
    end
  end
end
