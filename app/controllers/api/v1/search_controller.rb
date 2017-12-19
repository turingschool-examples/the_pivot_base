class Api::V1::SearchController < ActionController::API 
  def index
    if Key.authenticate_key?(params[:api_key])
      @search = ransack_params
      render json: ransack_result, each_serializer: ItemSerializer
    else 
      render json: {error: 'Result is Invalid'}
    end 
  end 

  private 
  
    def ransack_params
      Item.ransack(title_or_description_cont: params[:q])
    end

    def ransack_result
      @search.result(distinct: true)  
    end 
 
end 