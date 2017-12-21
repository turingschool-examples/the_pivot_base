class ValidationController < ApplicationController
  def create
    response = ShippingAddress.new(params).validate_address?
    if response
      flash[:success] = "Address is Valid!"
    else
      flash[:error] = "Invalid address!"
    end
    redirect_to new_order_path
  end
end
