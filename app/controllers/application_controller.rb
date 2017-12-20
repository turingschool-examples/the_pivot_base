class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart, :set_stores

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_owner?
    current_user && current_user.owner?
  end 

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_stores
    @stores = Store.all
    @categories = Category.all
  end
  
  private
  def require_admin
    not_found unless current_admin?
  end
 
  def require_owner
    not_found unless current_owner?
  end 

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
