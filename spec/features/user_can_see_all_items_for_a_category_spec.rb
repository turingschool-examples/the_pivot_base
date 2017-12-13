require 'rails_helper'

feature "Viewing items by category" do
	context "when a visitor of any authorization visits /categories/:slug" do
		it "shows them all items by category" do
			category = create(:category)
			store = create(:store)
			item_1 = create(:item,title: "Dog Slippers", store: store, category: category)
			item_2 = create(:item,title: "Cat Purse", store: store, category: category)
			item_3 = create(:item,title: "Owl Leotard",store: store, category: category)

			visit "/categories/#{category.title}"

			expect(page).to have_content(item_1.title)
			expect(page).to have_content(item_2.title)
			expect(page).to have_content(item_3.title)
		end 	

		it "/:slug does not work" do
			category = create(:category)
			store = create(:store)
			item_1 = create(:item,title: "Dog Slippers", store: store, category: category)
			item_2 = create(:item,title: "Cat Purse", store: store, category: category)
			item_3 = create(:item,title: "Owl Leotard",store: store, category: category)

			visit '/#{category.title}'

			expect(page).to_not have_content(item_1.title)
			expect(page).to_not have_content(item_2.title)
			expect(page).to_not have_content(item_3.title)
		end 
	end 
end 
