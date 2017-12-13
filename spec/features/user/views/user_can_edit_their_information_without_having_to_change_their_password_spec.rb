require 'rails_helper'

describe 'As a registered user, when i visit my account edit page' do
  before :each do
    user = create(:user)
    stub_logged_in_user(user)
  end
  it 'i can edit my information withougt entering my password' do
    visit "/account/edit"

    fill_in "user[first_name]", with: "George Oscar Bluth"

    click_on("Submit")

    expect(current_path).to eq("/account/edit")
    expect(page).to have_content("George Oscar Bluth")
  end
end
# As a logged in user
# When I visit "/account/edit"
# And I change my First Name to "George Oscar Bluth"
# And I don't enter a password to edit my other data
# And I click "Submit"
# Then I should be on "/account/edit"
# And I should see a my first name as "George Oscar Bluth"