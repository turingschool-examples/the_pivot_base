class DeveloperController < ApplicationController

  def new

  end 

  def create
    user = User.find(current_user.id)
    Key.create_key(user)
    redirect_to "/settings/developer"
  end 

  def show
    @key = current_user.key
  end 
end 