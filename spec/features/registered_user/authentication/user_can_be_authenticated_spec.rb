require "rails_helper"

feature "Returning user logs in" do
  describe "and is sent to their dashboard with 'logout' showing instead of 'login'" do

    user = create(:user)

    login_user(user.email, user.password)

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content "Logged in as #{user.first_name} #{user.last_name}"
    expect(page).to have_content "#{user.email}"
    expect(page).to_not have_link "Login"
    expect(page).to have_link "Logout"
  end 


  describe "As a registered user When I visit “/” Then I should see a link for “Login”" do
  describe "And when I click “Login” I should be on the “/login page”" do
    describe "And I should see a place to insert my credentials to login" do
      describe "And I fill in my email but no password " do
        it "I should see a message that says ""that log in was unsuccessful""" do

            user = create(:user)


            visit '/'

            expect(page).to have_link("Login")

            click_on "Login"
            expect(current_path).to eq(login_path)

            fill_in "session[email]", with: user.email


            within(".action") do
              click_on("Login")
            end

            expect(current_path).to eq(login_path)
            expect(page).to have_content "That login was unsuccessful"
          end
        end
      end
    end

    describe "As a registered user When I visit “/” Then I should see a link for “Login”" do
    describe "And when I click “Login” I should be on the “/login page”" do
      describe "And I should see a place to insert my credentials to login" do
        describe "And I fill in the wrong email  " do
          it "I should see a message that says ""that log in was unsuccessful""" do

              user = create(:user)

              visit '/'

              expect(page).to have_link("Login")

              click_on "Login"
              expect(current_path).to eq(login_path)

              fill_in "session[email]", with: user.email
              fill_in "session[password]", with: "test"


              within(".action") do
                click_on("Login")
              end

              expect(current_path).to eq(login_path)
              expect(page).to have_content "That login was unsuccessful"

            end
          end
        end
      end
    end

  end
end
