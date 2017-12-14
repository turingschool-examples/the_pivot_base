require 'rails_helper'

describe "User visits an active stores show page" do
  before :each do
    @store = create(:store, name: "Vandelay Industries")
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
