class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?, :current_platform_admin?
  before_action :set_cart, :set_categories, :set_chatroom

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_platform_admin?
    current_user.platform_admin?
  end

  def current_store_admin?
    current_user.store_admin?
  end

  def current_store_manager?
    current_user.store_manager?
  end

  def current_admin?
    current_user && (current_platform_admin? || current_store_admin? || current_store_manager?)
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end

  def set_chatroom
    @chatroom = Chatroom.first
  end

  def authorize!
    current_permission = PermissionService.new(current_user, params[:controller], params[:action])
    not_found unless current_permission.authorized?
  end

  private
    def require_admin
      not_found unless current_admin?
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
