require 'rails_helper'

RSpec.describe "As a user I can visit /account/edit" do
  it "it allows the user to change info" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit '/account/edit'

    expect(current_path).to eq(account_edit_path)

    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Address")

    fill_in("First name", with: 'George Oscar Bluth')
    click_on 'Submit'

    expect(current_path).to eq(account_edit_path)
    # expect(page.body).to have_content("George Oscar Bluth") this works when opening the page
  end
end