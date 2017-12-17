class Api::V1::SearchController < Api::V1::BaseController
  def index
    if params[:type] && params[:q] && params[:type] == "items"
      items = Item.where(like("title", params)).or(Item.where(like('description', params)))
      # render json: items, include: params[:type]
      json_response({'type': params[:type], 'q': params[:q], results: items})
    else
      params_formatting_error
    end
  end

  private
    def like(attr, params)
      return "#{attr} ILIKE ?", "%#{params[:q]}%"
    end

    def params_formatting_error
      json_response({ message: "Missing params. This endpoint is hit like /api/v1/search?type=ITEMS&q=DESCRIPTION"}, :not_found)
    end
end

# {
#   "type": "items",
#   "q": "diapers",
#   "results": [
#     {
#       "id": 1,
#       "title": "Nature's Diapers",
#       "description": "No chemicals or dyes. Also, they don't really work.",
#       "price": "$30.00"
#     },
#     {
#       "id": 103,
#       "title": "Dopo Tesigns Shoulder Bag",
#       "description": "Versitile bag great for commuting. Even makes as an excellent diaper bag. #dadcore #momcore",
#       "price": "$125.00"
#     }
#   ]
# }