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
    session.clear
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
    flash[:notice] = "Logged in as #{@user.full_name}"
    if @user.platform_admin? || @user.store_admin? || @user.store_manager?
      redirect_to admin_dashboard_index_path
    else
      redirect_to dashboard_index_path
    end
  end


end
