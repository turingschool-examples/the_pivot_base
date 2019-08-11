class PlatformAdmin::UsersController < ApplicationController

  def index
    @users = User.account_manager(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to  platform_admin_users_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to platform_admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password)
  end
end
