
require 'rails_helper'

RSpec.feature "Adding items to the cart" do
  let!(:store) { create(:store)}
  let!(:item) { create(:item, title: "Black Cat Onesie", price: 10.00, store: store) }

  let!(:store_2) { create(:store)}
  let!(:item_2) { create(:item, title: "Unicorn Onesie", price: 10.00, store: store_2) }

  before(:each) do
    visit store_items_path(store)
    # byebug
  end

  context "When a visitor adds items to their cart" do
    it "a message is displayed" do
      expect(page).to have_link("Add to cart")

      click_on "Add to cart"

      expect(page).to have_content("You now have 1 Black Cat Onesie")
    end

    it "the message correctly increments for multiple items" do
      click_on "Add to cart"
      expect(page).to have_content("You now have 1 Black Cat Onesie")
      click_on "Add to cart"
      expect(page).to have_content("You now have 2 Black Cat Onesies")
    end


    it "user can add items from many stores" do

      click_on "Add to cart"
      visit store_items_path(store_2)
      click_on "Add to cart"
      visit carts_path
      expect(page).to have_content(item.title)
      expect(page).to have_content(item_2.title)
    end

    it "they can click cart and see all their checkout items" do
      click_on "Add to cart"
      click_on "Add to cart"
      click_on "Cart"

      expect(current_path).to eq(carts_path)
      # expect(page).to have_css("img[src='book_cover.png']") #UNRESOLVED

      expect(page).to have_content(item.title)
      expect(page).to have_content("2")
    
      expect(page).to have_content "$20.00"
    
    end
  end
end
