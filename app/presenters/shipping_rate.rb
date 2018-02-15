class ShippingRate
  #turns the parsed JSON into an object to pass around

  attr_reader :retail_rate_priority

  def initialize(rate)
    @retail_rate_first = rate[:rates][0][:retail_rate]
    @retail_rate_parcel = rate[:rates][1][:retail_rate]
    @retail_rate_express = rate[:rates][2][:retail_rate]
    @retail_rate_priority = rate[:rates][3][:retail_rate]
  end

  def self.rate(user, package)
    ShippingRate.new(call_easy_post(user, package).get_rates)
  end

  def self.call_easy_post(user, package)
    EasyPostService.new(user, package)
  end

  def grand_total_priority(subtotal)
    subtotal.to_f + retail_rate_priority.to_f
  end


end
