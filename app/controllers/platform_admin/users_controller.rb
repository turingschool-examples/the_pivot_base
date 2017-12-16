class PlatformAdmin::UsersController < ApplicationController

  def index
    @users = User.account_manager(current_user.id)
  end

  def edit
    @users = User.find(params[:id])
  end
end
