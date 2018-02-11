class Stores::ItemsController < Stores::StoresBaseController
  before_action :ensure_active_store
  def index 
    store = Store.find_by(slug: params[:store])
    @items = store.items
  end

  def show
    store = Store.find_by(slug: params[:store])
    @item = store.items.find(params[:id])
  end

  private
    def ensure_active_store 
      store = Store.find_by(slug: params[:store])
      if store.inactive?
        flash[:warning] = "store is no longer active "
        redirect_to root_path
      end
    end
end
