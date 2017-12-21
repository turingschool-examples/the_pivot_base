require 'fedex'

class ShippingAddress
  def initialize(attrs={})
    @fedex = Fedex::Shipment.new(key: ENV['FEDEX_KEY'],
                                 password: ENV['FEDEX_PW'],
                                 account_number: ENV['FEDEX_NUM'],
                                 meter: ENV['FEDEX_METER'],
                                 mode: 'development')
    @attrs = attrs
  end

  def address
    {street: attrs["street_address"],
     city: attrs["city"],
     state: attrs["states"],
     postal_code: attrs["postal_code"],
     country: attrs["country"] }
  end

  def empty_address?(address)
    address.values.any? { |value| value == nil || value.empty? }
  end

  def validate_address?
    if empty_address?(address)
      return false
    else
      fedex.validate_address(address: address).residential
    end
  end

  private
    attr_reader :attrs, :fedex
end
