class ValidationController < ApplicationController

  def create
    ShippingAddress.new(params).validate_address.to_json
  end
end
