require 'rails_helper'

  feature "owner dashboard" do
    feature "owner can visit owner's dashboard" do
      scenario "I will see a heading on the page that says Owner Dashboard" do
        owner = create(:owner)
        store = create(:store, user: owner)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(owner)

        visit owner_dashboard_index_path(owner)
        expect(page).to have_content("Owner Dashboard")
      end
    end
  end

  describe "as a logged in user when I visit /owner/dashboard" do
    it "I see a 404 error" do
      default_user = create(:user, first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom")

      expect {
        visit owner_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end


  describe "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do
      expect {
        visit owner_dashboard_index_path
      }.to raise_error(ActionController::RoutingError)
    end
  end


feature "as an owner" do
  describe "when I log into my account" do

    it "I am redirected to the Owner Dashboard" do
      owner = create(:owner)
      store = create(:store, user: owner)
      visit login_path


      fill_in "session[email]", with: owner.email
      fill_in "session[password]", with: owner.password
      within(".action") do
        click_on("Login")
      end

      expect(page).to have_content("You're logged in as owner of #{store.name}")

      expect(current_path).to eq(owner_dashboard_index_path)
    end
  end
end