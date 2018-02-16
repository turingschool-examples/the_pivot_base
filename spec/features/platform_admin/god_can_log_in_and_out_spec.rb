require 'rails_helper'

RSpec.describe "As a Platform Admin I can login and logout" do
  it "I login and see my dashboard" do
    god = create(:platform_admin)
    role = create(:role, title: "platform_admin")
    user_role = create(:user_role, user: god, role: role)


    visit '/'
    click_on 'Login'
    fill_in "session[email]", with: god.email
    fill_in "session[password]", with: god.password

    click_button("Login")


    expect(current_path).to eq(admin_dashboard_index_path)
    expect(page).to have_content("You're logged in as an Administrator")

    click_on 'Logout'
    expect(page).to have_content("Login")
  end
end
