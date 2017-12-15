class DeveloperController < ApplicationController

  def new

  end 

  def create
    user = User.find(current_user.id)
    
    byebug
  end 
end 