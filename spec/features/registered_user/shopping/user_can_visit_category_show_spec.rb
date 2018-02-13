require 'rails_helper'
describe "As a visitor can visit category show page" do
    it " can visit category show page" do
      category = create(:category, title: "cats")
        item_one = create(:item, category: category)
        item_two = create(:item, category: category)

        visit '/cats'

        expect(current_path).to eq(category_path(category))
    end
    
    it "can see items associated with that category only" do
      category = create(:category, title: "cats")
      category2 = create(:category)
      item_one = create(:item, category: category)
      item_two = create(:item, category: category)
      item_three = create(:item, category: category2)

      visit '/cats'

      expect(page).to have_content(item_one.title)
      expect(page).to have_content(item_two.title)
      expect(page).to_not have_content(item_three.title)
    end
end
