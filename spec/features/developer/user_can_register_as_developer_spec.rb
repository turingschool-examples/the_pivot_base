require 'rails_helper'

RSpec.feature "User can register as developer" do
  it "from main page" do
    user = create(:user, password: 'LOGIN')
    login_user(user.email, 'LOGIN')
    visit "/"
    within "footer" do
      click_on "Developer"
    end
    click_on "Register"

    expect(current_path).to be('/settings/developer')
    expect(page).to have_css('#api-key')
  end
end
