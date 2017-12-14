class Settings::DeveloperController < ApplicationController
  before_action :check_developer, except: [:new, :create]

  def show

  end

  def new

  end

  def create
    developer_service = DeveloperService.new(user: current_user)
    developer_service.register_as_developer
    redirect_to settings_developer_path
  end

  private

    def check_developer
      unless current_user && current_user.developer?
        redirect_to settings_developer_new_path
      end
    end

end
