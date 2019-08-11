class PermissionService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.platform_admin?
      platform_admin_user_permissions
    elsif user.store_admin?
      store_admin_user_permissions
    elsif user.store_manager?
      store_manager_user_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  attr_reader :user, :controller, :action

  def guest_user_permissions
    return true if controller == "main" && action.in?(%w(index))
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "items" && action.in?(%w(index show)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "users" && action.in?(%w(new create))
  end

  def registered_user_permissions
    return true if controller == "main" && action.in?(%w(index))
    return true if controller == "stores" && action.in?(%w(index show new create))
    return true if controller == "items" && action.in?(%w(index show)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "orders" && action.in?(%w(index create show )) #change controller method from new to create
    return true if controller == "users" && action.in?(%w(edit update show ))
    return true if controller == "dashboard" && action.in?(%w(index))
  end

  def store_manager_user_permissions
    return true if controller == "main" && action.in?(%w(index))
    return true if controller == "admin/stores" && action.in?(%w(index show new create))
    return true if controller == "admin/items" && action.in?(%w(update edit index show)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "orders" && action.in?(%w(index create show update)) #change controller method from new to create
    return true if controller == "users" && action.in?(%w(edit update show))
    return true if controller == "store_manager" && action.in?(%w(index))
    return true if controller == "admin/stores" && action.in?(%w(show))
  end

  def store_admin_user_permissions
    return true if controller == "main" && action.in?(%w(index))
    return true if controller == "admin/stores" && action.in?(%w(index show new create update edit))
    return true if controller == "admin/items" && action.in?(%w(update edit index show destroy new create)) #potentially nested resource with category or store
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index create update destroy))
    return true if controller == "admin/orders" && action.in?(%w(index create show update)) #change controller method from new to create
    return true if controller == "users" && action.in?(%w(edit update show))
    return true if controller == "store_admin" && action.in?(%w(index))
    return true if controller == "user_roles" && action.in?(%w(index new create update destroy))
  end


  def platform_admin_user_permissions
    true
  end
end
