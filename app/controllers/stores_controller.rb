class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    store = Store.find_by(slug: params[:slug])
    store.update(store_params)
    redirect_to admin_store_dashboard_index_path(store)
  end
end
 private

 def store_params
   params.require(:store).permit(:name)
 end
