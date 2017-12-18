require 'rails_helper'

feature "Admin can view individual order pages" do
  let!(:role)             {create(:role, name: 'platform admin')}
  let!(:admin)            {create(:user, email: "admin@example.com")}
  let!(:user_role_store)  {create(:user_role_store, user: admin, role: role)}
  let!(:user)             {create(:user)}


  scenario "when I visit an valid order page" do
    item_1, item_2 = create(:item, price: 11.00), create(:item)
    item_hash      = [ {item_1 => 1}, {item_2 => 2} ]
    order          = create(:order_with_items, items_with_quantity: item_hash)
    expected_total = "$31.00"

    stub_logged_in_user(admin)

    visit order_path(order)

    expect(page).to have_content(order.date)
    expect(page).to have_content("Gob Bluth")
    expect(page).to have_content(user.address)
    within("#item-#{item_1.id}") do
      within(".title") { expect(page).to have_link(item_1.title) }
      within(".quantity") { expect(page).to have_content(item_1.order_items.first.quantity) }
      within(".price") { expect(page).to have_content("$11.00") }
    end
    within("#item-#{item_2.id}") do
      within(".title") { expect(page).to have_link(item_2.title) }
      within(".quantity") { expect(page).to have_content(item_2.order_items.last.quantity) }
      within(".price") { expect(page).to have_content("$10.00") }
    end
    within(".order-total") do
      expect(page).to have_content(expected_total)
    end
  end
end
