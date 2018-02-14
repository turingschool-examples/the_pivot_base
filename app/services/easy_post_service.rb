class EasyPostService
# turns parsed JSON response into an object to pass around

  attr_reader :user, :package

  def initialize(user, package)
    @user = user
    @package = package
  end

  # pass user, package to the get_rates() and get_verification() methods

  def get_rates(user, package)
    response = connection.post("/shipments?") do |request|
      request.params['api_key'] = ENV['USPS_TEST_KEY']
      request.params['verify[]'] = ['delivery']
      request.params['address[street1]'] = ["#{user.address}"]
      request.params['address[street2]'] = ["#{user.address_2}"]
      request.params['address[city]'] = ["#{user.city}"]
      request.params['address[state]'] = ["#{user.state}"]
      request.params['address[zip]'] = ["#{user.zip}"]
      request.params['address[country]'] = ["US"]
      request.params['address[company]'] = ["#{user.store}"]
      request.params['address[phone]'] = ["#{user.phone}"]
    end
    JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
  #     req.params['roll'] = ['california', 'philadelphia']
  #  GET 'http://sushi.com?roll=california&roll=philadelphia'



  def get_verification(user)
    response = connection.post("/address?", verification_params)
    JSON.parse(response.body, symbolize_names: true)
  end



  def connection
    Faraday.new("https://api.easypost.com/v2") do |f|
      # f.header['api_key'] = ENV['USPS_TEST_KEY']
      f.adapter Faraday.default_adapter
    end
  end
  # Faraday.new(...) do |conn|
  #   conn.basic_auth('username', 'password')
  # end




  def shipping_rate_params(user, package)
    params = {
      "shipment[to_address][name]" => "Lauren Billington",
      "shipment[to_address][street1]" => "2765 28th street",
      "shipment[to_address][street2]" => "321",
      "shipment[to_address][city]" => "Boulder",
      "shipment[to_address][state]" => "CO",
      "shipment[to_address][zip]" => "80301",
      "shipment[to_address][country]" => "US",
      "shipment[to_address][phone]" => "7199648875",
      # shipment[to_address][name] => "#{user.address}",
      # shipment[to_address][street1] => "#{user.address}",
      # shipment[to_address][street2] => "#{user.address2}",
      # shipment[to_address][city] => "#{user.city}"
      # shipment[to_address][state] => "#{user.state}",
      # shipment[to_address][zip] => "#{user.zip}",
      # shipment[to_address][country] => "US",
      # shipment[to_address][phone] => "#{user.phone}",

      "shipment[to_address][id]" => "adr_9dd20853a65d4bbf8c303501799511cd",
      # shipment[from_address][name] => "Little Shop",
      # shipment[from_address][street1] => "1331 17th Street",
      # shipment[from_address][street2] => "L100",
      # shipment[from_address][city] => "Denver",
      # shipment[from_address][state] => "CO",
      # shipment[from_address][zip] => "80202",
      # shipment[from_address][country] => "US",
      # shipment[from_address][phone] => "3038765309",
      # shipment[from_address][email] => "blbillington1@gmail.com",

      "shipment[parcel][length]" => "12",
      "shipment[parcel][width]"=> "10",
      "shipment[parcel][height]" => "4",
      "shipment[parcel][weight]" => "2"
      # shipment[parcel][length] => "#{package.length}",
      # shipment[parcel][width] => "#{package.width}",
      # shipment[parcel][height] => "#{package.height}",
      # shipment[parcel][weight] => "#{package.weight}",
      }
  end


end

#
# shipment[to_address][name]:Lauren Billington
# shipment[to_address][street1]:2765 28th street
# shipment[to_address][street2]:321
# shipment[to_address][city]:Boulder
# shipment[to_address][state]:CO
# shipment[to_address][zip]:80301
# shipment[to_address][country]:US
# shipment[to_address][phone]:7199648875
# shipment[from_address][name]:Little Shop
# shipment[from_address][street1]:1331 17th Street
# shipment[from_address][street2]:L100
# shipment[from_address][city]:Denver
# shipment[from_address][state]:CO
# shipment[from_address][zip]:80202
# shipment[from_address][country]:US
# shipment[from_address][phone]:3038765309
# shipment[from_address][email]:blbillington1@gmail.com
# shipment[parcel][length]:12
# shipment[parcel][width]:10
# shipment[parcel][height]:4
# shipment[parcel][weight]:2
