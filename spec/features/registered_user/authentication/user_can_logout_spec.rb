 require 'rails_helper'

RSpec.describe "As a visitor I can login" do
	it "as a user I can log out" do
    user = create(:registered_user)
		visit '/'
		click_on 'Login'
		fill_in "session[email]", with: user.email
		fill_in "session[password]", with: user.password

			click_button("Login")

		click_on 'Logout'
		expect(page).to have_content("Login")

	end

end
