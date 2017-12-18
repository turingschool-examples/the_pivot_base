class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:provider].present?
      @user = User.from_omniauth(request.env['omniauth.auth'])
      login_successful
    else
      @user = User.find_by(email: params[:session][:email])
      verify_user
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def verify_user
    if @user && @user.authenticate(params[:session][:password])
      login_successful
    else
      flash[:failure] = "That login was unsuccessful"
      redirect_to login_path
    end
  end

  def login_successful
    session[:user_id] = @user.id
    flash[:notice] = "Logged in as #{@user.first_name} #{@user.last_name}"
    if @user.platform_admin?
      redirect_to platform_admin_dashboard_path
    elsif @user.store_admin?
      redirect_to store_admin_dashboard_path
    elsif @user.store_manager?
      redirect_to store_manager_dashboard_path
    elsif @user.registered_user?
      redirect_to dashboard_index_path
    end
  end


end
