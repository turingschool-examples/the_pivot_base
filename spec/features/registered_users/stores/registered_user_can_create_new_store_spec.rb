require 'rails_helper'

feature 'a registered user applies to create a new store' do
  let(:user) {create(:user)}
  let(:store_admin) {create(:platform_admin)}

  it "they see a link to create a new store" do
    login_user(user.email, user.password)
    visit dashboard_index_path

    expect(current_path).to have_link("New Store Application")
  end
end
