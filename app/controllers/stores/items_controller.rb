class Stores::ItemsController < Stores::StoresBaseController
  def index 
    store = Store.find_by(slug: params[:store])
    @items = store.items
  end

  def show
  end
end