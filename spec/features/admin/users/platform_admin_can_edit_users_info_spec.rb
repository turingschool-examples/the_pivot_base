require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
    3.times do
      create(:store)
    end
    @user = create(:user, first_name: "Mig")
    5.times do |n|
      create(:store_admin)
      create(:store_manager)
      create(:user, first_name: "Gob#{n}")
    end
  end
  it "click on a user name and takes you to the user edit page" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_users_path

    click_on "Mig"

    expect(current_path).to eq("/platform_admin/users/#{@user.id}/edit")
    expect(page).to have_content("Mig")

    fill_in "user[first_name]", with: "Miguel"
    click_on "Update User"

    expect(User.find(@user.id).first_name).to eq("Miguel")
  end

end
