require 'rails_helper'

feature 'a registered user applies to create a new store' do
  let(:user) {create(:user)}
  let(:store_admin) {create(:platform_admin)}

  it "they see a link to create a new store" do
    login_user(user.email, user.password)
    visit dashboard_index_path

    expect(page).to have_link("New Store Application")
  end

  it "they see a form to create a new store" do
    login_user(user.email, user.password)
    visit dashboard_index_path
    click_on("New Store Application")

    expect(current_path).to eq(new_store_path)
    expect(page).to have_button("Create Application")
  end

  it "they can create an application for a new business" do
    login_user(user.email, user.password)
    visit dashboard_index_path
    click_on("New Store Application")
    fill_in 'store[name]', with: 'The Banana Stand'
    click_on "Create Application"

    expect(page).to have_content("You have successfully submitted an application for The Banana Stand!")
  end
end
