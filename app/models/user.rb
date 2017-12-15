class User < ApplicationRecord
  has_secure_password
  has_many   :orders
  has_one    :store
  has_one    :key

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: ["default", "admin"]

# TWITTER STUFF
  def self.update(auth, user)
    user.uid = auth[:uid]
    user.oauth_secret = auth[:credentials][:secret]
    user.oauth_token = auth[:credentials][:token]
    user.password = 'password'
    user.save!
    user
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end

    client.update(tweet)
  end
  # TWITTER STUFF ENDS HERE

  def full_name
    first_name + " " + last_name
  end

  def date_joined
    created_at.strftime('%b. %d, %Y')
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end
end
