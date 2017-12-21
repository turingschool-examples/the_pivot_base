require "rails_helper"

describe "Visitor can visit stores" do
  it "when clicking on the stores link" do
    store = create(:store, status: 2)
    visit '/'

    click_on 'Stores'

    expect(current_path).to eq "/stores"
    expect(page).to have_content store.name
  end
end

describe "Visitor cannot visit store" do
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
