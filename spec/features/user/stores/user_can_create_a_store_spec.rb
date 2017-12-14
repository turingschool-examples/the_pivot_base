require "rails_helper"

feature "User can create a new store" do
	it "once they have logged in" do
	#	As a logged in user
	user = create(:user, first_name: "Josh")
	stub_logged_in_user(user)
	#When I visit "/stores/new"
	visit '/stores/new'
	#And I fill in the name field with "Vandelay Industries"
	fill_in "store[name]", with: "Vandelay Industries"
	#And I click "Submit"
	click_on "Create Store"
	#Then I should be on "/dashboard"
	expect(current_path).to eq '/dashboard'
	#And I should see a tab for "My Stores"
	expect(page).to have_content "My Stores"
	#And When I click "My Stores"
	click_on "My Stores"
	#I should see "Vandelay Industries" with a status of "pending"
	expect(page).to have_content("Vandelay Industries")
	end 
end 
