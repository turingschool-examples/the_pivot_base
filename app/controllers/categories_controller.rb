class CategoriesController < ApplicationController
	def show
		@category = Category.friendly.find_by(title: params[:slug])
	end
end
