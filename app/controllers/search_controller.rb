class SearchController < ApplicationController 

  def index
    # @items is an array of item objects
    @search = ransack_params
    @items = ransack_result
  end 

  private 

    def ransack_params
      Item.ransack(title_or_description_cont: params["search"])
    end

    def ransack_result
      @search.result(distinct: true)  
    end 
end 