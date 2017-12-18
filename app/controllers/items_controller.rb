class ItemsController < ApplicationController
	def index
		@items = Item.all.paginate(page: params[:page], per_page: 20)
	end
  def index
    store  = Store.find_by(slug: params[:store])
    @items = store.items
  end

  def show
    @item = Item.find(params[:id])
  end
end
