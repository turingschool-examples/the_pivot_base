require 'rails_helper'

describe "Registered User visits store" do
  it "they see items for that store and no other stores' items" do
    user = create(:user, email: "testerson@testmail.com", password: "testing")
    role = create(:role)
    user_role = create(:user_role, user: user, role: role)
    store1 = create(:store, name: "Vandelay Industries")
    store2 = create(:store)
    item1 = create(:item, store: store1, condition: 0)
    item2 = create(:item, store: store1, condition: 0)
    item3 = create(:item, store: store1, condition: 1)
    item4 = create(:item, store: store2, condition: 0)

    visit store_items_path(store1)

    expect(current_path).to eq('/vandelay-industries/items')
    expect(page).to have_content(item1.title)
    expect(page).to have_content(item2.title)
    expect(page).to_not have_content(item3.title)
    expect(page).to_not have_content(item4.title)

  end

end
