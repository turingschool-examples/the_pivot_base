class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    store = Store.new(store_params)
    if store.save
      flash[:success] = "You have successfully submitted an application for #{store.name}!"
      redirect_back(fallback_location: dashboard_index_path)
    else
      flash[:danger] = "Please try your application again."
      render :new
    end
  end

  def show
    @store = Store.find_by(name: params[:store_name])
    @items = @store.items
  end

  private
      def store_params
        params.require(:store).permit(:name)
      end
end
