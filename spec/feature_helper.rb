module FeatureHelper
  def login_user(email, password)
    visit '/'

    click_on "Login"

    fill_in "session[email]", with: email
    fill_in "session[password]", with: password


      click_button("Login")

  end

  def stub_logged_in_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
