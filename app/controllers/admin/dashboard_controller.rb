class Admin::DashboardController < ApplicationController
before_action :require_admin
  def index
    require 'pry'; binding.pry
    
    @admin = User.find(current_user.id)
  end

private
  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
