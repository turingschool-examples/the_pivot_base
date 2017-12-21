require 'rails_helper'

RSpec.feature "User can register as developer" do
  it "from main page" do
    user = create(:user, password: 'LOGIN')
    login_user(user.email, 'LOGIN')
    visit "/"
    within ".nav" do
      within all('.nav-item').last do
        click_on "Developer"
      end
    end
    click_on "Register"

    expect(current_path).to eq('/settings/developer')
  end
end
