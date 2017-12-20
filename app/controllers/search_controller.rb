class SearchController < ApplicationController 

  def index
    @search = ransack_params
    @items = ransack_result
    if @items.length == 1
      item = @items.first
      redirect_to store_item_path(item.store, item)
    end 
  end 

  private 

    def ransack_params
      Item.ransack(title_or_description_cont: params["search"])
    end

    def ransack_result
      @search.result(distinct: true)  
    end 
end 