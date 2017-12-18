class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
    session[:user_id] = user.id
    redirect_to dashboard_index_path
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    dashboard_redirect
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end

  def dashboard_redirect
    if current_user.platform_admin?
      flash[:notice] = "Successfully updated your account information."
      redirect_to platform_admin_dashboard_path
    elsif current_user.store_admin?
      flash[:notice] = "Successfully updated your account information."
      redirect_to store_admin_dashboard_path
    elsif current_user.store_manager?
      flash[:notice] = "Successfully updated your account information."
      redirect_to store_manager_dashboard_path
    elsif current_user != nil
      flash[:notice] = "Successfully updated your account information."
      redirect_to dashboard_index_path
    else
      render file: "/public/404"
    end
  end
end
