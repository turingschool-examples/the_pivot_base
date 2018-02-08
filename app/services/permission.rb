class Permission
  def initialize(user, controller, action)
    @user = user
    @controller = controller
    @action = action
  end

  def authorized?
    if controller == 'stores' && action == 'index'
      true
    end
  end

  private
    attr_reader :controller, :user, :action
end
