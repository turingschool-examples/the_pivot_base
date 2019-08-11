require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
    create(:category, title: "Electronics")
  end
  it "can delete a category" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_categories_path

    click_on 'Delete Category'

    expect(current_path).to eq('/platform_admin/categories')
    expect(Category.all.count).to eq(0)
  end

end
