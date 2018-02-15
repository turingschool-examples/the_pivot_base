class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart, :set_categories
  before_action :authorize!

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_store_admin?
    current_user && current_user.store_admin?
  end

  def current_store_manager?
    current_user && current_user.store_manager?
  end

   def current_platform_admin?
    current_user && current_user.platform_admin?
  end



  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end

  private

    def authorize!
      not_found unless current_permission.authorized?
    end

    def current_permission
      @current_permission ||= Permission.new(current_user, params[:controller], params[:action])
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
