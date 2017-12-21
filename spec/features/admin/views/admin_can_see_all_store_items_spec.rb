require 'rails_helper'

RSpec.describe 'A store admin can visit view stores' do
  let!(:role)             { create(:role, name: 'store admin') }
  let!(:admin)            { create(:user, email: "admin@example.com") }
  let!(:store)            { create(:store) }
  let!(:user_role_store)  { create(:user_role_store, user: admin, role: role, store: store) }

  it 'and click on store name to view all store items' do
    stub_logged_in_user(admin)

    item_one, item_two = create_list(:item, 2, category: create(:category), store: store)

    visit admin_stores_path

    click_on store.name

    expect(page).to have_content(item_one.title)
    expect(page).to have_content(item_one.price)
    expect(page).to have_content(item_two.title)
    expect(page).to have_content(item_two.price)
    expect(page).to have_content("Edit")
  end
end
