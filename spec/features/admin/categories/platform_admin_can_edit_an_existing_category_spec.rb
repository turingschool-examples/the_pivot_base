require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
    create(:category, title: "Electronics")
  end
  it "can edit a category" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_categories_path

    click_on 'Edit Category'

    expect(current_path).to eq("/platform_admin/categories/1/edit")

    fill_in "category[title]", with: "Books"
    click_on "Update Category"

    expect(current_path).to eq('/platform_admin/categories')
    expect(page).to have_content("Books")
  end

end
