#need to update the /items path to be show/items_path

#need to update the test objects to have a store


require "rails_helper"

feature "Visitor can edit cart contents" do

  context "they can increase and decrease quantity" do
   it "they can decrease the quantity" do
      store = create(:store)
      item = create(:item, price: 19.99, store: store)
      visit store_items_path(store)

      click_on "Add to cart"
      click_on "Add to cart"

      visit carts_path
      expect(page).to have_content(2)
      expect(page).to have_content(39.98)
      expect(page).to have_content(item.title)

      click_on "-"

      expect(page).to have_content(19.99)
      expect(page).to have_content(item.title)
      expect(page).to have_content("$19.99")
    end

    it "they can increase the quantity" do
      store = create(:store)
      item = create(:item, price: 19.99, store: store)
      visit store_items_path(store)

      click_on "Add to cart"

      visit carts_path
      expect(page).to have_content(1)
      expect(page).to have_content(19.99)
      expect(page).to have_content(item.title)

      click_on "+"

      expect(page).to have_content(39.98)
    end
  end


  context "they can remove items from the cart" do
    it "they can remove by clicking '-' " do
      store = create(:store)
      item = create(:item, price: 19.99, store: store)
      visit store_items_path(store)

      click_on "Add to cart"

      visit carts_path

      expect(page).to have_content(1)
      expect(page).to have_content(item.title)
      expect(page).to have_content("$19.99")

      click_on "-"

      expect(page).to have_content("Successfully removed")
    end

    xit "they can remove by clicking 'Remove' " do
      store = create(:store)
      item = create(:item, price: 19.99, store: store)
      visit store_items_path(store)

      click_on "Add to cart"

      visit carts_path

      expect(page).to have_content(1)
      expect(page).to have_content(item.title)
      expect(page).to have_content("$19.99")

      click_on "Remove"

      expect(page).to have_content("Successfully removed")
    end
  end

end
