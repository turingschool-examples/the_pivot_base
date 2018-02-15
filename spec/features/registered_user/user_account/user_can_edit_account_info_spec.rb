require 'rails_helper'

describe "Registered user account details" do
  context "they visit their account page and can edit details" do
    it "i can edit my own account" do
      user = create(:user)
      role = Role.create(title: "registered_user")
      create(:user_role, user: user, role: role)

      visit '/'

      click_on "Login"

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password

      click_button("Login")

      new_email_address = "kramer@example.com"
      new_password      = "cosmo"

      visit dashboard_index_path
      click_on "My Account"
      fill_in "user[email]", with: new_email_address
      fill_in "user[password]", with: new_password
      click_on "Submit"

      click_on "Logout"
      login_user(new_email_address, new_password)
      expect(current_path).to eq("/dashboard")
    end
  end
end
