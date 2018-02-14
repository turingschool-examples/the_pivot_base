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
    response = connection.post("/shipments?", shipping_rate_params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def shipping_rate_params
    {

      
    }


  end


end
