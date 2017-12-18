require 'rails_helper'

describe 'As a registered user, when i visit my account edit page' do
  before :each do
    @user = create(:user)
    stub_logged_in_user(@user)
  end

  it 'i can edit my information withougt entering my password' do
    visit "/account/edit"

    fill_in "user[first_name]", with: "George Oscar Bluth"

    click_on("Submit")

    expect(current_path).to eq("/account/edit")

    within("#user_first_name") do
      expect(@user.first_name).to eq("George Oscar Bluth")
    end
    expect(page).to have_content("Successfully Updated Your Account Information")
  end
end
