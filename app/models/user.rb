class User < ApplicationRecord
  has_secure_password
  has_many   :orders
  has_one    :store
  has_one    :key
  has_many   :user_roles
  has_many   :roles, through: :user_roles

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: ["default", "admin"]

  # Stripe stuff
  def save_credit_card_details(last4digits, expiration_month, expiration_year)
    self.credit_card.save_credit_card_details(last4digits, expiration_month, expiration_year)
  end

  # TWITTER STUFF
  def self.update(auth, user)
    user.uid          = auth[:uid]
    user.oauth_secret = auth[:credentials][:secret]
    user.oauth_token  = auth[:credentials][:token]
    user.password     = 'password'
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

  def owner?
    flag = false
    self.roles.each {|role| flag = true if role.name == "owner"}
    flag
  end

  def admin?
    flag = false
    self.roles.each {|role| flag = true if role.name == "admin"}
    flag
  end

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
