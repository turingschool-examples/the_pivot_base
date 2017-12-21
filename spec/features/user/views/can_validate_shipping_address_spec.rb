require 'rails_helper'

describe "User can input address for valitaion" do
  before(:each) do
    user = create(:user)
    store = create(:store, status: 2)
    create(:item, category: create(:category), store: store)
    stub_logged_in_user(user)
    visit "/#{store.slug}"
    click_on "Add to cart"
    click_on "Cart"
    click_on "Checkout"
  end

  xit "and a message valid appears if address is valid" do
    click_on "Enter Shipping Address"
    fill_in "street_address", with: "1883 S Glencoe St"
    fill_in "city", with: "Denver"
    select "Colorado", from: "states"
    fill_in "postal_code", with: 80222
    click_on "Submit"

    expect(page).to have_content("Address is Valid")
  end

  xit "and a message invalid appears if address is invalid" do
    click_on "Enter Shipping Address"
    fill_in "street_address", with: ""
    fill_in "city", with: "Edgewater"
    select "Colorado", from: "states"
    fill_in "postal_code", with: ""
    click_on "Submit"

    expect(page).to have_content("Invalid address!")
  end
end
