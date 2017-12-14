class DeveloperService

  def initialize(params)
    @user = params[:user]
  end

  def register_as_developer
    if @user && !@user.developer?
      ApiKey.create(user: @user)
      @user.roles << Role.find_or_create_by(name: 'developer')
    end
  end

end
