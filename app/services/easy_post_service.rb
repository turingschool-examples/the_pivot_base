class EasyPostService
# turns parsed JSON response into an object to pass around

  attr_reader :user, :package

  def initialize(user, package)
    @user = user
    @package = package
  end

  def connection
    Faraday.new("https://api.easypost.com") do |f|
      f.basic_auth(ENV['USPS_TEST_KEY'], nil)
      f.adapter Faraday.default_adapter
    end
  end


  def get_verification
    response = connection.post("/v2/addresses") do |f|
      f.params = verification_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def verification_params
    params = {
      "address[street1]" => "417 Montgomery Street",
      "verify[]" => "delivery",
      "address[street2]" => "5",
      "address[city]" => "SF",
      "address[zip]" => "94104",
      "address[country]" => "US",
      "address[company]" => "EasyPost",
      "address[phone]" => "415-123-4567"
    }
  end



  def get_rates
    response = connection.post("/v2/shipments") do |f|
      f.params = shipping_rate_params
    end
    JSON.parse(response.body, symbolize_names: true)
    # binding.pry
  end


  def shipping_rate_params
    params = {
      "shipment[to_address][name]":"#{user.first_name} #{user.last_name}",
      "shipment[to_address][street1]":"#{user.address}",
      "shipment[to_address][street2]":"#{user.address_2}",
      "shipment[to_address][city]":"#{user.city}",
      "shipment[to_address][state]":"#{user.state}",
      "shipment[to_address][zip]":"#{user.zip}",
      "shipment[to_address][country]":"US",
      "shipment[to_address][phone]":"#{user.phone}",
      "shipment[from_address][company]":"Little Shop",
      "shipment[from_address][street1]":"1331 17th Street",
      "shipment[from_address][street2]":"L100",
      "shipment[from_address][city]":"Denver",
      "shipment[from_address][state]":"CO",
      "shipment[from_address][zip]":"80202",
      "shipment[from_address][country]":"US",
      "shipment[from_address][phone]":"3038765309",
      "shipment[from_address][email]":"blbillington1@gmail.com",
      "shipment[parcel][length]":"#{package.length}",
      "shipment[parcel][width]":"#{package.width}",
      "shipment[parcel][height]":"#{package.height}",
      "shipment[parcel][weight]":"#{package.weight}"
    }
  end


  def test_shipping_params
      params = {
      "shipment[to_address][name]":"Lauren Billington",
      "shipment[to_address][street1]":"2765 28th street",
      "shipment[to_address][street2]":"321",
      "shipment[to_address][city]":"Boulder",
      "shipment[to_address][state]":"CO",
      "shipment[to_address][zip]":"80301",
      "shipment[to_address][country]":"US",
      "shipment[to_address][phone]":"7199648875",
      "shipment[from_address][company]":"Little Shop",
      "shipment[from_address][street1]":"1331 17th Street",
      "shipment[from_address][street2]":"L100",
      "shipment[from_address][country]":"US",
      "shipment[from_address][phone]":"3038765309",
      "shipment[from_address][email]":"blbillington1@gmail.com",
      "shipment[parcel][length]":"12",
      "shipment[parcel][width]":"10",
      "shipment[parcel][height]":"4",
      "shipment[parcel][weight]":"2"
      }
  end


end
