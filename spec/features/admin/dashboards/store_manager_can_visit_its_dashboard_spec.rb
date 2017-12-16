require 'rails_helper'

describe 'when a store manager visits its dashboard' do

  let(:admin) {create(:store_manager_with_multiple_stores)}

  it "they see all their stores on the page" do
    login_user(admin.email, admin.password)
    visit store_manager_dashboard_path

    expect(current_path).to eq("/store_manager/dashboard")
    expect(page).to have_link("#{admin.stores.first.name}")
    expect(page).to have_link("#{admin.stores.second.name}")
    expect(page).to have_link("#{admin.stores.last.name}")
  end
end
