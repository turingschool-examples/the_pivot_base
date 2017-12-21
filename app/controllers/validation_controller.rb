class ValidationController < ApplicationController
  def create
    ShippingAddress.new(params).validate_address
  end
end
