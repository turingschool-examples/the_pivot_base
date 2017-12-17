require 'rails_helper'

  feature "admin dashboard" do
    before(:each) do
      @user = create(:user)
      @role = Role.create(name: "admin")
      @user_role = UserRole.create(user: @user, role: @role)
    end 
    feature "admin can visit the admin dashboard" do
      scenario "I will see a heading on the page that says Admin Dashboard" do
#        admin_user = create(:user, first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", role: "admin")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit admin_dashboard_index_path
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end

feature "as an Admin" do
  describe "when I log into my account" do

    it "I am redirected to the Admin Dashboard" do
      @user = create(:user)
      @role = Role.create(name: "admin")
      @user_role = UserRole.create(user: @user, role: @role)

      visit login_path

      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      within(".action") do
        click_on("Login")
      end

      expect(page).to have_content("You're logged in as an Administrator")

      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end
