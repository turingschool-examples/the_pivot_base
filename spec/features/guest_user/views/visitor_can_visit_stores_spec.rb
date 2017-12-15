require "rails_helper"

describe "Visitor can visit stores" do
  it "when clicking on the stores link" do
    store = create(:store, status: 2)
    visit '/'

    click_on 'Stores'
  
    expect(current_path).to eq "/stores"
    expect(page).to have_content store.name
  end
end
