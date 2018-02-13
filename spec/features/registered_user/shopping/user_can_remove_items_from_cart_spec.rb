require 'rails_helper'

RSpec.feature "User can remove item from cart" do
  it "deletes an item from the cart" do
    user = create(:user, email: "testerson@testmail.com", password: "testing")
    role = create(:role)
    user_role = create(:user_role, user: user, role: role)
    store = create(:store)
    item_one = create(:item, store: store)

    visit store_items_path(store)

    click_on "Add to cart"

    visit cart_path

    click_on "Remove"

    expect(page).to have_content("Successfully removed #{item_one.title} from your cart.")
  end
end
