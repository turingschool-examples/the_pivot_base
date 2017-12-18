class Admin::StoresController < ApplicationController

  def show
    @store = Store.find_by(url: params[:store_name])
  end

  def edit
    @store = Store.find_by(url: params[:store_name])
    @statuses = Store.statuses.keys
  end

  def update
    store = Store.find_by(url: params[:store_name])
    if store.update(store_params)
      flash[:success] = "#{store.name} successfully updated"
      redirect_to admin_store_path(store.url)
    else
      flash[:danger] = "Please try updating again"
      redirect_to admin_edit_store_path(store)
    end
  end

  private
      def store_params
        params.require(:store).permit(:name).tap do |whitelisted|
          whitelisted[:status] = params[:status]
        end
      end
end
