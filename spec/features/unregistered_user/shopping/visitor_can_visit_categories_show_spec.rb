#need to update the /items path to be show/items_path

#need to update the test objects to have a store

require 'rails_helper'

describe "As a visitor can visit category show page" do
  it "can visit category show page" do
    magic = create(:category, title: "Magic")
    sci_fi = create(:category, title: "Sci-Fi")
    create(:item, title: "Dove", category: magic)
    create(:item, title: "Light Saber", category: sci_fi)

    visit '/magic'

   
      expect(page).to have_content("Dove")
      expect(page).to_not have_content("Light Saber")
  end
end
