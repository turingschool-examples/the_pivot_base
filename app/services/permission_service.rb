class PermissionService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    #we will add
  end

  private

  attr_reader :user, :controller, :action

  def guest_user_permissions
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "items" && action.in?(%w(index show)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "users" && action.in?(%w(new create))
  end

  def registered_user_permissions
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "items" && action.in?(%w(index show)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "orders" && action.in?(%w(index create show )) #change controller method from new to create
    return true if controller == "users" && action.in?(%w(edit update show )) 
  end

end
