class Permission
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.platform_admin?
      platform_admin_permissions

    elsif user.store_admin?
        store_admin_permissions

    elsif user.store_manager?
        store_manager_permissions

    elsif user.registered_user?
      registered_user_permissions
    else
      unregistered_user_permissions
    end
  end

  private
    attr_reader :controller, :user, :action

    def platform_admin_permissions
      return true
    end

    def store_admin_permissions
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == 'carts' && action.in?(%w(index create update destroy))
      return true if controller == 'stores' && action.in?(%w(index edit update))
      return true if controller == 'stores/items' && action.in?(%w(index show))
      return true if controller == 'categories' && action.in?(%w(index show))
      return true if controller == 'orders' && action.in?(%w(index show new create edit update))
      return true if controller == 'admin/store' && action.in?(%w(edit update))
      return true if controller == 'admin/stores/items' && action.in?(%w(index show new create edit update destroy))
      return true if controller == 'admin/stores/orders' && action.in?(%w(index show new create edit update destroy))
      return true if controller == 'admin/stores/users' && action.in?(%w(index new create edit update destroy))
      return true if controller == 'admin/dashboards' && action.in?(%w(index ))
      return true if controller == 'admin/stores/analytics' && action.in?(%w(index ))
      return true if controller == 'admin/stores/dashboard' && action.in?(%w(index))
      return true if controller == 'shipping' && action.in?(%w(show))
      return true if controller == 'users' && action.in?(%w(create new edit update))

    end

    def store_manager_permissions
      return true if controller == 'stores' && action.in?(%w(index update))
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == 'stores/items' && action.in?(%w(index show))
      return true if controller == 'categories' && action.in?(%w(index show))
      return true if controller == 'carts' && action.in?(%w(index create update destroy))
      return true if controller == 'orders' && action.in?(%w(index show new create edit update))
      return true if controller == 'admin/stores/items' && action.in?(%w(index new create edit update destroy))
      return true if controller == 'admin/stores/orders' && action.in?(%w(index new create edit update))
      return true if controller == 'admin/analytics' && action.in?(%w(index ))
      return true if controller == 'admin/stores/dashboard' && action.in?(%w(index))
      return true if controller == 'shipping' && action.in?(%w(show))
      return true if controller == 'users' && action.in?(%w(edit update))


    end

    def registered_user_permissions
      return true if controller == 'stores' && action.in?(%w(index new create))
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == 'stores/items' && action.in?(%w(index show))
      return true if controller == 'categories' && action.in?(%w(index show))
      return true if controller == 'carts' && action.in?(%w(index create update destroy))
      return true if controller == 'charges' && action.in?(%w(new index create))
      return true if controller == 'orders' && action.in?(%w(index show new))
      return true if controller == 'dashboard' && action.in?(%w(index))
      return true if controller == 'shipping' && action.in?(%w(show))
      return true if controller == 'users' && action.in?(%w(edit update))

    end

    def unregistered_user_permissions
      return true if controller == 'stores' && action.in?(%w(index))
      return true if controller == 'dashboard' && action.in?(%w(index))
      return true if controller == 'users' && action.in?(%w(new create edit update destroy))
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == 'stores/items' && action.in?(%w(index show))
      return true if controller == 'categories' && action.in?(%w(index show))
      return true if controller == 'carts' && action.in?(%w(index show new create edit update destroy))
    end
end
