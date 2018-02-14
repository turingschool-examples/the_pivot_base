class ShippingController < ApplicationController

  def show
    @cart_decorator = CartDecorator.new(@cart)
    package = PackageDecorator.new(@cart)
    @shipping = Shipping.new(current_user, package)

  end



end
