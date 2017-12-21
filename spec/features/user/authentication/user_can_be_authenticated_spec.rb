require "rails_helper"

describe "User can login" do
  let!(:user) { create(:user, password: "testing") }
  it "user visits login path and fills in credentials and logs in" do

    login_user(user.email, "testing")

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content "Logged in as Gob Bluth"
    expect(page).to have_content user.email

    expect(page).to_not have_link "Login"
    expect(page).to have_link "Logout"
  end

  it "should flash message for unsuccessful login" do
    visit '/'

    expect(page).to have_link("Login")

    click_on "Login"
    expect(current_path).to eq(login_path)

    fill_in "session[email]", with: "testerson@testmail.com"

    within(".action") do
      click_on("Login")
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content "Login unsuccessful"
  end
end