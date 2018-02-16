#need to update the /items path to be show/items_path

#need to update the test objects to have a store


require 'rails_helper'

RSpec.describe "Visitor user can view items" do
  let!(:store) {create(:store)}
  let!(:dove) { create(:item, title: "Dove", price: 5.00, store: store) }
  let!(:seal) { create(:item, title: "Seal", price: 100.00, store: store) }

  before do
    visit store_items_path(store)
  end

  it "from the root, visitor can visit items index and see all items" do
    expect(page).to have_content("Dove")
    expect(page).to have_content("$5.00")
    expect(page).to have_content("Seal")
    expect(page).to have_content("$100.00")
  end

  it "from the item index, visitor can visit an item's show page" do
    click_on dove.title

    expect(page).to have_content(dove.title)
    expect(page).to have_content(dove.description)
    expect(page).to have_content(dove.price)
    expect(page).to have_content("Shop")


    visit store_items_path(store)
    click_on seal.title

    expect(page).to have_content
    expect(page).to have_content(seal.title)
    expect(page).to have_content(seal.description)
    expect(page).to have_content(seal.price)
  end
end
