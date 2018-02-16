class Admin::StoresController < ApplicationController

  def edit
		@store = Store.find_by(slug: params[:store])
	end

	def update
    store = Store.find_by(slug: params[:store])
    store.update(params[:name])
	end
end
