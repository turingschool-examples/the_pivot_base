require "rails_helper"

describe "User can register as a developer" do 
  it "gives them an API key and saves it to the db" do 
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)

    visit '/dashboard'
    
    expect(current_path).to eq "/dashboard"
    
    click_on "Developer"

    click_on "Register"

    expect(current_path).to eq "/settings/developer"
    expect(page).to have_content "API key:"
  end
end