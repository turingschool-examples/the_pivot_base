class Admin::DashboardsController < ApplicationController
  def index
    @admin = User.find(current_user.id)
  end
end
