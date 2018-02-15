class Shipping
  #turns the parsed JSON into an object to pass around

  attr_reader :user, :package

  def initialize(user, package)
    @user = user
    @package = package
  end

  def rate
    #rate should initialize an instance of shipping that has methods I can call to invoke data in the view
    # I only need to return a rate
    call_easy_post.get_rates(user, package)
  end

  def verify(user, package)
    #verify should initialize an instance of shipping that has methods I can call to invoke data in the view
    call_easy_post(user, nil)[:filter_the_heck_out_of_the_hash!]
  end



  def call_easy_post
    EasyPostService.new(user, package)
  end


end
