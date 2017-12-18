require "rails_helper"

feature "User can create a new store" do
  it "once they have logged in" do
    user = create(:user, first_name: "Josh")

    stub_logged_in_user(user)

    visit '/stores/new'

    fill_in "store[name]", with: "Vandelay Industries"

    click_on "Create Store"

    expect(current_path).to eq '/dashboard'
    expect(page).to have_content "View All Stores"

    click_on "View All Stores"

    expect(page).to have_content("Vandelay Industries")
  end 
end 
