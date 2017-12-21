class Admin::PermissionsController < ApplicationController
  before_action :require_admin

  def index
    @admins = User.admins(current_user)
  end

  def destroy
    admin = User.find(params[:id])
    admin.user_role_stores.destroy_all
    redirect_to admin_permissions_path
  end

end
