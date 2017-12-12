require 'rails_helper'

feature "As a user, I can visit category show page" do
  scenario "and see items under that category" do
    category = create(:category)
    item1    = create(:item, category: category)
    item2    = create(:item, category: category)

    visit "/categories/#{category.slug}"

    expect(current_path).to eq "/categories/#{category.slug}"
    expect(page).to have_content item1.title
    expect(page).to have_content item1.price
    expect(page).to have_content item2.title
    expect(page).to have_content item2.price
  end
end
