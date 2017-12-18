require 'rails_helper'

describe "when a user visits its dashboard and clicks on update account" do
  before(:each) do
    @user = create(:user)
  end
    it "can update an account without a password" do
      login_user(@user.email, @user.password)

      click_on "Edit Account"

      expect(current_path).to eq('/account/edit')

      fill_in "user[first_name]", with: "Miguel"
      click_on "Update User"

      expect(page).to have_content("Miguel")
    end
end
