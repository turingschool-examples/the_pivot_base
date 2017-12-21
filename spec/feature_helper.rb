module FeatureHelper
  def login_user(email, password)
    visit '/login'

    fill_in "session[email]", with: email
    fill_in "session[password]", with: password

    within(".login-form") do
      click_on("Login")
    end
  end

  def stub_logged_in_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
