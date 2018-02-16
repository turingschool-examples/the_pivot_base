class ShippingVerification
  #turns the parsed JSON into an object to pass around

  attr_reader :user

  def initialize(user, verify={})
    @user = user
  
  end


  def verify
    ShippingVerification.new(call_easy_post.get_verification(user))
  end


  def call_easy_post
    EasyPostService.new(user, nil)
  end


end
