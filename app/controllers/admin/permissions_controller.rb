class Admin::PermissionsController < ApplicationController
  before_action :require_admin

  def index
    @admins = User.admins(current_user)
  end

end
