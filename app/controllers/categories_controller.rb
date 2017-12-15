class CategoriesController < ApplicationController
	def show
		@category = Category.friendly.find_by(slug: params[:slug])
	end
end
