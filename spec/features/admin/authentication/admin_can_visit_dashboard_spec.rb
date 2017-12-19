require 'rails_helper'

feature "admin dashboard" do
  let!(:role)             {create(:role, name: 'platform admin')}
  let!(:admin_user)       {create(:user, email: "admin@example.com")}
  let!(:user_role_store)  {create(:user_role_store, user: admin_user, role: role)}

  scenario "I will see a heading on the page that says Admin Dashboard" do
    stub_logged_in_user(admin_user)

    visit admin_dashboard_index_path
    expect(page).to have_content("Admin Dashboard")
  end

  context "as a logged in user when I visit /admin/dashboard" do
    it "I see a 404 error" do
      default_user = create(:user)
      stub_logged_in_user(default_user)

      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end

  context "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end

  context "when I log into my account" do
    it "I am redirected to the Admin Dashboard" do

      visit login_path

      fill_in "session[email]", with: admin_user.email
      fill_in "session[password]", with: admin_user.password
      within(".action") do
        click_on("Login")
      end

      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end
