require 'rails_helper'

RSpec.feature "admin can edit item" do
  it "from items index" do
    user = create(:user, password: "LOGIN")
    user.roles.create(name: "platform_admin")
    item = create(:item)
    title = item.title
    login_user(user.email, "LOGIN")

    visit items_path

    click_on "Edit", match: :first
    fill_in "item[title]", with: "NUNU"
    click_on "Submit"

    expect(page).to_not have_content(title)
    expect(page).to have_content("NUNU")
  end

  it "from admin items index" do
    user = create(:user, password: "LOGIN")
    user.roles.create(name: "platform_admin")
    item = create(:item)
    title = item.title
    login_user(user.email, "LOGIN")

    visit admin_items_path

    click_on "Edit", match: :first
    fill_in "item[title]", with: "NUNU"
    click_on "Submit"

    expect(page).to_not have_content(title)
    expect(page).to have_content("NUNU")
  end

  it "from item show" do
    user = create(:user, password: "LOGIN")
    user.roles.create(name: "platform_admin")
    item = create(:item)
    title = item.title
    login_user(user.email, "LOGIN")

    visit item_path(item)

    click_on "Edit", match: :first
    fill_in "item[title]", with: "NUNU"
    click_on "Submit"

    expect(page).to_not have_content(title)
    expect(page).to have_content("NUNU")
  end
  
  it "unless not authenticated" do
    item = create(:item)
    title = item.title

    visit items_path

    expect(page).to_not have_content("Edit")
  end
end
