class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart, :set_categories, :authorize!

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end


  private

    def authorize!
      current_permission = PermissionService.new(current_user, params[:controller], params[:action])
      not_found unless current_permission.authorized?
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
