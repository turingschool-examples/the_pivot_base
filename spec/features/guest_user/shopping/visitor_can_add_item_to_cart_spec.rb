#need to update the /items path to be show/items_path

#need to update the test objects to have a store



require 'rails_helper'

RSpec.feature "Adding items to the cart" do
  let!(:store) { create(:store)}
  let!(:item) { create(:item, title: "Black Cat Onesie", price: 10.00, store: store) }

  before(:each) do
    visit store_items_path(store)
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

    xit "user can add items from many stores" do



      click_on "Add to cart"


    end

    it "they can click cart and see all their checkout items" do
      click_on "Add to cart"
      click_on "Add to cart"
      click_on "Cart"

      expect(current_path).to eq(carts_path)
      expect(page).to have_css("img[src=\"#{item.image}\"]")
      expect(page).to have_content(item.title)
      expect(page).to have_content("2")
      within '.total' do
        expect(page).to have_content "$20.00"
      end
    end
  end
end
