class PermissionService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    case
    when user.platform_admin?
      return true if controller == "admin/stores" && action.in?(%w(index show update))
    when user.store_admin?
      return true if controller == "admin/stores" && action.in?(%w(index show))
    when user.store_manager?
      return true if controller == "admin/stores" && action.in?(%w(index show))
    else
      return false
    end
  end

  private
    attr_reader :user, :controller, :action
end
