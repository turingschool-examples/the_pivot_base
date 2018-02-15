require "rails_helper"

describe "Returning user logs in" do
  context "with valid credentials" do
    it "and is sent to their dashboard with 'logout' showing instead of 'login'" do

      user = create(:registered_user)

      login_user(user.email, user.password)

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content "Logged in as #{user.first_name} #{user.last_name}"
      expect(page).to have_content "#{user.email}"
      expect(page).to_not have_link "Login"
      expect(page).to have_link "Logout"
    end
  end


  context "without valid credentials"  do
    it "they attenpt ogin without a password" do
      user = create(:registered_user)
      visit '/'

      click_on "Login"
      expect(current_path).to eq(login_path)

      fill_in "session[email]", with: user.email
        click_button("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content "That login was unsuccessful"
    end

    it "they use an invalid email address" do

      user = create(:registered_user)
      visit '/'
      click_on "Login"
      expect(current_path).to eq(login_path)

      fill_in "session[email]", with: "wrong@wrong.com"
      fill_in "session[password]", with: "test"
        click_button("Login")


      expect(current_path).to eq(login_path)
      expect(page).to have_content "That login was unsuccessful"

    end


  end
end
