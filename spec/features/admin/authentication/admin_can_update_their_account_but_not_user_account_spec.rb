require "rails_helper"

describe "As a logged in Store Admin" do
  before(:all) do
    @admin = create(:user, email: "store_admin@example.com")
    role = create(:role, name: "store_admin")
    store = create(:store)
    #create(:user_role, user: @admin, role: role, store: store)
  end

  # before(:all) do
  #   @admin = create(:user, email: "store_admin@example.com")
  #   role = create(:role, name: "store_admin")
  #   store = create(:store)
  #   create(:user_role, user: @admin, role: role, store: store)
  # end

  let(:admin) {create(:store_admin)}

  it "I can modify my account data" do
    login_user(@admin.email, @admin.password)
    new_email_address = "kramer@example.com"
    new_password      = "cosmo"

    visit admin_dashboard_index_path
    click_on "Update Account"
    fill_in "user[email]", with: new_email_address
    fill_in "user[password]", with: new_password
    click_on "Submit"

    click_on "Logout"
    login_user(new_email_address, new_password)
    expect(current_path).to eq("/admin/dashboard")
  end

  it "returns a 404 when an admin visits registered user dashboard" do

    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(@admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
    user = create(:user)

    expect {
      visit dashboard_index_path(user)
    }.to raise_error(ActionController::RoutingError)
  end

  xit "I can modify another store admin role" do
    # allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(@admin)
    # visit admin_dashboard_index_path
    #
    #
    # expect {
    #   visit dashboard_index_path(user)
    # }.to raise_error(ActionController::RoutingError)
  end

  it "returns a welcome message for admins" do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(@admin)
    visit admin_dashboard_index_path
    expect(page).to have_content("You're logged in as an Administrator")
  end

  it "returns a 404 when a non-admin visits the admin dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
    expect {
      visit admin_dashboard_index_path
    }.to raise_error(ActionController::RoutingError)
  end
end
