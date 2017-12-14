class PermissionService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action

    def authorized?
      case
      when user.platform_admin?
        return true if controller == "admin/stores" && action.in?(%w(index show update))
      else
        return false
      end
    end
  end

  private
    attr_reader :user, :controller, :action
end