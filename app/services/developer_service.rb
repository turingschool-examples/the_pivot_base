class DeveloperService

  def initialize(params)
    @user = params[:user]
  end

  def register_as_developer
    if user && !user.developer?
      key = generate_key
      user.create_api_key(key: key)
      raise ArgumentError if !user.api_key
      make_developer_role
      mail_developer_key
    end
  end

  def generate_key
    Digest::SHA512.hexdigest(Time.now.to_s + user.email)
  end

  private
    attr_reader :user

    def make_developer_role
      user.roles << Role.find_or_create_by(name: 'developer')
    end

    def mail_developer_key
      DeveloperMailer.welcome_email(user).deliver_now
    end

end
