 require 'rails_helper'

RSpec.describe "As a visitor I can login" do
	it "as a user I can log out" do
		user = create(:user)

		login_user(user.email, user.password)

		click_on 'Logout'
		expect(page).to have_content("Login")
	end
end
