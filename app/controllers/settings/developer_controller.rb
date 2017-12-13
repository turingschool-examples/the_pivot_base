class Settings::DeveloperController < ApplicationController

  def show

  end

  private

    def check_developer
      unless current_user && current_user.developer?
        redirect_to new_developer_path
      end
    end

end
