class Api::V1::SearchController < ApplicationController
  def index
    require 'pry'; binding.pry
    # params is currently {"type"=>"items", "q"=>"diapers", 
    #"controller"=>"api/v1/search", "action"=>"index"}
    #So here is where I need to put the code from ransack
  end 
end 