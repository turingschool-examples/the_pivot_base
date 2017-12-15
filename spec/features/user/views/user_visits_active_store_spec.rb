require 'rails_helper'

describe "User visits an active stores show page" do
  before :each do
    @store = create(:store, name: "Vandelay Industries", status: 2)
    @item1 = create(:item, store: @store)
    @item2 = create(:item, store: @store)
    @item3 = create(:item, store: @store, condition: 1)
  end
  it "they see a list of all the active items" do
    visit "/#{@store.slug}"

    expect(page).to have_content(@item1.title)
    expect(page).to have_content(@item2.title)
    expect(page).to_not have_content(@item3.title)
  end
end

describe "User cannot visit store" do
  it "when store is inactive" do
    store1 = create(:store, status: 2)
    store2 = create(:store, status: 1)
    store3 = create(:store, status: 0)
    visit '/'

    click_on 'Stores'

    expect(current_path).to eq "/stores"
    expect(page).to have_content store1.name
    expect(page).to_not have_content store2.name
    expect(page).to_not have_content store3.name
  end
end
