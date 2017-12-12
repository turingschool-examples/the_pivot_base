require "rails_helper"

describe "Visitor decreases item quantity in cart" do
  it "item count decreases and price reflects decrease" do
    item = create(:item, price: 19.99)
    visit items_path

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

  it "Visitor decreases item quantity to zero and item is removed" do
    item = create(:item, price: 19.99)
    visit items_path

    click_on "Add to cart"

    visit carts_path

    expect(page).to have_content(1)
    expect(page).to have_content(item.title)
    expect(page).to have_content("$19.99")

    click_on "-"

    expect(page).to have_content("Successfully removed")
  end
end
