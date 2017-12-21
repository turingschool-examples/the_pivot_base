require 'rails_helper'

RSpec.feature "user can create a store" do
  it "after logging in" do
    user = create(:user, password: "login")
    login_user(user.email, "login")

    expect(page).to have_content("Create Store")

    click_on "Create Store"
    
    expect(current_path).to eq('/stores/new')

    fill_in "name", with: "Vandelay Industries"
    click_on "Submit"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("My Stores")

    click_on "My Stores"

    expect(page).to have_content("Vandelay Industries")
    expect(page).to have_content("pending")
  end

  it "without logging in" do
    visit "/"

    expect(page).to_not have_content("Create Store")
  end
end
