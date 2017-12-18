class Api::V1::SearchController < Api::ApplicationController
  def index
    @search = ransack_params
    render json: ransack_result, each_serializer: ItemSerializer
  end 
  private 
  
    def ransack_params
      Item.ransack(title_or_description_cont: params[:q])
    end

    def ransack_result
      @search.result(distinct: true)  
    end 
 
end 