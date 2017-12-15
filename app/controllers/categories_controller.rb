class CategoriesController < ApplicationController
	def show
		@category = Category.find_by(url: params[:category])
	end
end
