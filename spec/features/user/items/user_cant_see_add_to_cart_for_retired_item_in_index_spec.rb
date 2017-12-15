require 'rails_helper'

RSpec.describe 'As a visitor' do
	describe 'when visiting an items show page' do
		it 'a user cannot see add to cart for a retired item' do
			store = create(:store, status: 2)
			create(:item, condition: 'retired', category: create(:category))

			visit "/#{store.slug}/items"

			expect(page).not_to have_content("Add to cart")
		end
	end
end
