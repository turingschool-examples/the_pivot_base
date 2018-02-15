class Admin::Stores::UsersController < ApplicationController
  def index
    store = Store.find_by(slug: params[:store])
    users = User.where(store_id: store.id).joins(:roles)
    @users = users.where(roles: { title: 'store_manager' }).or(users.where(roles: { title: 'store_admin' }))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_store_admin?
      user = User.find(params[:id])
      user.update(user_params)
      redirect_to admin_store_dashboard_index_path(params[:store])
    else
      render file: "/public/404"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end


end
