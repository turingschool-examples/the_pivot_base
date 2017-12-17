require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
  end
  it "clicks on categories" do
    login_user(@platform_admin.email, @platform_admin.password)

    click_on "All Categories"

    expect(current_path).to eq("/platform_admin/categories")
  end

end
