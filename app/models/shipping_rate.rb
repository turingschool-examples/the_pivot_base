class ShippingRate
  #turns the parsed JSON into an object to pass around


  def rate(user, package)
    EasyPostService.new(user, package)
end
