class ShippingController < ApplicationController

  def show
    @cart_decorator = CartDecorator.new(@cart)
    package = PackageDecorator.new(@cart)
    @shipping_rates = ShippingRate.rate(current_user, package)
  end

end
