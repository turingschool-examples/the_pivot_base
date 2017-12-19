class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:provider].present?
      twitter_login
    else
      @user = User.find_by(email: params[:session][:email])
      verify_user
    end
  end

  def destroy
    session.clear; redirect(root_path)
  end

  private
    def twitter_login
      if @user = User.from_omniauth(request.env['omniauth.auth'])
        login_successful
      else
        flash_failure
        redirect(login_path)
      end
    end

    def verify_user
      if @user && @user.authenticate(params[:session][:password])
        login_successful
      else
        flash_failure
        redirect(login_path)
      end
    end

    def login_successful
      set_user
      flash_success
      admin? ? redirect(admin_dashboard_index_path) : redirect(dashboard_index_path)
    end

    def redirect(path)
      redirect_to path
    end

    def admin?
      @user.platform_admin? || @user.store_admin? || @user.store_manager?
    end

    def set_user
      session[:user_id] = @user.id
    end

    def flash_failure
      flash[:failure] = "Login unsuccessful"
    end

    def flash_success
      flash[:notice] = "Logged in as #{@user.full_name}"
    end
end
