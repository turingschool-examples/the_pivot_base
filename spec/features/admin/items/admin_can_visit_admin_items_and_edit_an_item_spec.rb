require 'rails_helper'

describe 'A store admin can visit store items' do
  let!(:role)             { create(:role, name: 'platform admin') }
  let!(:admin)            { create(:user, email: "admin@example.com") }
  let!(:store)            { create(:store) }
  let!(:user_role_store)  { create(:user_role_store, user: admin, role: role, store: store) }
  let!(:item)             { create(:item, store: store) }

  it 'and see all items for that store' do
    stub_logged_in_user(admin)

    visit admin_store_items_path(store)

    click_on "Edit"
    fill_in "item[title]", with: "White Cat Twosie"
    fill_in "item[description]", with: "two is better"
    fill_in "item[price]", with: "39.99"
    page.attach_file("item[image]", testing_image)
    click_on "Update"

    expect(page).to have_content("White Cat Twosie")
    expect(page).to have_content("39.99")
  end
end
