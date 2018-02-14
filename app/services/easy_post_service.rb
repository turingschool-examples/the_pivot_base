class EasyPostService
# turns parsed JSON response into an object to pass around

  def connection
    Faraday.new(https://api.easypost.com/v2) do |f|
      f.headers ["Authorization"] = "Basic aUlmeE5nMEV2bGcwTVdYN2ttTlFhUTo="
      f.adapter = Faraday.default_adapter
    end
  end

# ADDRESS VERIFICATION

    def get_verification
      response = connection.post("/address?", verification_params)
      JSON.parse(response.body, symbolize_names: true)
    end

    def verification_params(user)
      {
      verify[]: "delivery",
      address[street1]: "#{user.address}",
      address[street2]: "#{user.address}",
      address[city]: "#{user.address}",
      address[zip]: "#{user.address}",
      address[country]: "#{user.address}",
      address[company]: "#{user.address}",
      address[phone]: "#{user.address}" ***Needs to be 7199648875
      }
    end


# SHIPPING rate

  def get_rates
                connection.get('/nigiri', { :name => 'Maguro' })
    response = connection.post("/shipments?", shipping_rate_params)
    JSON.parse(response.body, symbolize_names: true)[:rates][0][:retail_rate]
  end

  def shipping_rate_params(user, package)
    {
      shipment[to_address][name]:"Lauren Billington",
      shipment[to_address][street1]:"2765 28th street",
      shipment[to_address][street2]:"321",
      shipment[to_address][city]:"Boulder",
      shipment[to_address][state]:"CO",
      shipment[to_address][zip]:"80301",
      shipment[to_address][country]:"US",
      shipment[to_address][phone]:"7199648875",
      # shipment[to_address][name]: "#{user.address}",
      # shipment[to_address][street1]: "#{user.address}",
      # shipment[to_address][street2]: "#{user.address2}",
      # shipment[to_address][city]: "#{user.city}"
      # shipment[to_address][state]: "#{user.state}",
      # shipment[to_address][zip]: "#{user.zip}",
      # shipment[to_address][country]: "US",
      # shipment[to_address][phone]: "#{user.phone}",

      shipment[to_address][id]: "adr_9dd20853a65d4bbf8c303501799511cd",
      # shipment[from_address][name]: "Little Shop",
      # shipment[from_address][street1]: "1331 17th Street",
      # shipment[from_address][street2]: "L100",
      # shipment[from_address][city]: "Denver",
      # shipment[from_address][state]: "CO",
      # shipment[from_address][zip]: "80202",
      # shipment[from_address][country]: "US",
      # shipment[from_address][phone]: "3038765309",
      # shipment[from_address][email]: "blbillington1@gmail.com",

      shipment[parcel][length]: "12",
      shipment[parcel][width]: "10",
      shipment[parcel][height]: "4",
      shipment[parcel][weight]: "2"
      # shipment[parcel][length]: "#{package.length}",
      # shipment[parcel][width]: "#{package.width}",
      # shipment[parcel][height]: "#{package.height}",
      # shipment[parcel][weight]: "#{package.weight}",
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
