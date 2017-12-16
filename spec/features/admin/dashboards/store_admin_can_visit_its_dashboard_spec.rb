require 'rails_helper'

describe 'when a store admin visits its dashboard' do

  let(:admin) {create(:store_admin_with_multiple_stores)}

  it "they see all their stores on the page" do
    login_user(admin.email, admin.password)
    visit store_admin_dashboard_path

    expect(current_path).to eq("/store_admin/dashboard")
    expect(page).to have_link("#{admin.stores.first.name}")
    expect(page).to have_link("#{admin.stores.second.name}")
    expect(page).to have_link("#{admin.stores.last.name}")
  end

end
