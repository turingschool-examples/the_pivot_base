require "rails_helper"

describe "User can register as a developer" do 
  it "gives them an API key and saves it to the db" do 
# As a logged in user
    user = create(:user)
    # fill_in "session[email]", with: user.name
    # fill_in "session[password]", with: "password"
    # save_and_open_page
    # click_button "Login"
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
# When I visit "/Dashboard"
    visit '/dashboard'
    expect(current_path).to eq "/dashboard"
# And I click "Developer" (should be in the footer)
    click_on "Developer"
# And I click "Register"
    click_on "Register"
# Then my current path should be "/settings/developer"
    expect(current_path).to eq "/settings/developer"
# And I should see an API key
    expect(page).to have_content "API key:"
  end
end