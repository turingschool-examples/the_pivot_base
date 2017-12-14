require 'rails_helper'

RSpec.feature "Removing an item from my cart" do
  let!(:store) { create(:store) }
  let!(:item) { create(:item,store: store, price: 19.99) }

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
      expect(page).to have_link(item.title, href: item_path(item))
    end
  end
end
