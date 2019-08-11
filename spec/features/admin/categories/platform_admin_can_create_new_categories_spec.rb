require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
  end
  it "can create a new category" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_categories_path

    click_on 'New Category'

    expect(current_path).to eq("/platform_admin/categories/new")

    fill_in "category[title]", with: "Electronics"
    click_on "Create Category"

    expect(current_path).to eq('/platform_admin/categories')
    expect(page).to have_content("Electronics")
  end

end
