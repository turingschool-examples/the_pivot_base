class Api::V1::BaseController < ActionController::API
  include Response
  include ExceptionHandler

  def route_not_found
    render :json => {:error => "not found"}, :status => 404
  end
end
