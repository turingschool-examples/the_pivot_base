class StoresController < ApplicationController
  before_action :ensure_correct_admin, only: [:update, :edit]

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @store.status = "pending"
    @store.save
    redirect_to root_path
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    store = Store.find_by(slug: params[:slug])
    store.update(store_params)
    redirect_to admin_store_dashboard_index_path(store)
  end


 private

  def store_params
    params.require(:store).permit(:name)
  end

  def check_correct_admin
    return true if current_user.platform_admin?
    return false if !current_user.store_admin? && !current_user.store_manager?
    current_user.store.slug == params[:slug]
  end

  def ensure_correct_admin
    unless check_correct_admin
      flash[:notice] = "You do not have permissions for that"
      redirect_to root_path
    end
  end

end
