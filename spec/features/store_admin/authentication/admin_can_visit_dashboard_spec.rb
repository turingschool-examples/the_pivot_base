

#need to update paths to be store/admin/dashboard, etc!

require 'rails_helper'

  feature "admin dashboard" do
    describe "admin can visit the admin dashboard" do
      it "I will see a heading on the page that says Store Dashboard" do
        store = create(:store)
        admin_user = create(:store_admin, store: store)
        role = Role.create(title: "store_admin")
        create(:user_role, user: admin_user, role: role)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

        visit admin_store_dashboard_index_path(store)
        expect(page).to have_content("Store Dashboard")
      end
    end
  end

  describe "as a logged in user when I visit /admin/dashboard" do
    it "I see a 404 error" do
      default_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(default_user)

      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end


  describe "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end


feature "as an Admin" do
  describe "when I log into my account" do

    it "I am redirected to the Admin Dashboard" do
      store = create(:store)
      admin = create(:store_admin, store: store)
      role = Role.create(title: "store_admin")
      create(:user_role, user: admin, role: role)

      visit login_path


      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      click_button("Login")


      expect(page).to have_content("You're logged in as an Administrator")

      expect(current_path).to eq(admin_store_dashboard_index_path(store))
    end
  end
end
