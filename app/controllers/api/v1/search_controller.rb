class Api::V1::SearchController < Api::V1::BaseController
  def index
    if params[:type] && params[:q] && params[:type] == "items"
      items = Item.where(like("title", params)).or(Item.where(like('description', params)))
      json_response(items)
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