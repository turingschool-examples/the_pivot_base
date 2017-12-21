require 'rails_helper'

RSpec.feature "user receives an email" do
  it "when they register as a developer" do
    user = create(:user)
    stub_logged_in_user(user)

    visit "/"
    within ".nav" do
      within all('.nav-item').last do
        click_on "Developer"
      end
    end
    click_on "Register"

    mail = ActionMailer::Base.deliveries

    expect(mail[0].subject).to eq("Thank you for registering as a Developer!")
  end
end
