class StoresController < ApplicationController

	def new
		@store = Store.new
	end 

	def create
		@category = Category.new(title: params["store"]["name"] )
		@category.save
		redirect_to dashboard_index_path
	end 
end 
