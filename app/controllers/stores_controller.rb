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
    flash[:notice] = "Store created, currently waiting approval"
    redirect_to root_path
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    store = Store.find_by(slug: params[:slug])
    store.update(store_params)
    redirect_to root_path
  end


 private

  def store_params
    params.require(:store).permit(:name, :status)
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
