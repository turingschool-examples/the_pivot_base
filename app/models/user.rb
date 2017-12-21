class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :charges, through: :orders
  has_many :user_role_stores
  has_many :stores, through: :user_role_stores
  has_many :roles, through: :user_role_stores
  has_many :cards
  has_one  :api_key

  validates :first_name, :last_name, presence: true

  validates :password, presence: true, on: :create
  validates :email,    presence: true, uniqueness: true

  def self.update_from_omniauth(auth_info, user)
    user.uid                = auth_info.uid
    user.screen_name        = auth_info.extra.raw_info.screen_name
    user.oauth_token        = auth_info.credentials.token
    user.oauth_token_secret = auth_info.credentials.secret
    user.save!
  end

  def self.reset_twitter(user)
    user.update!(uid: nil, screen_name: nil, oauth_token: nil, oauth_token_secret: nil)
  end

  def send_tweet(params)
    conn = Twitter::REST::Client.new do |c|
      c.consumer_key        = ENV['TWITTER_KEY']
      c.consumer_secret     = ENV['TWITTER_SECRET']
      c.access_token        = self.oauth_token
      c.access_token_secret = self.oauth_token_secret
    end
    conn.update(params[:message])
end

  def platform_admin?
    roles.exists?(name: 'platform admin')
  end

  def store_admin?(store = nil)
    roles.exists?(name: 'store admin')
  end

  def store_manager?(store = nil)
    roles.exists?(name: 'store manager')
  end

  def developer?
    roles.exists?(name: "developer")
  end

  def create_charge(params)
    stripe_service = StripeService.new(user: self)
    stripe_service.create_charge(params)
  end

  def last_cards
    stripe_service = StripeService.new(user: self)
    stripe_service.sources.collect(&:last4).uniq
  end

  def full_name
    first_name + " " + last_name
  end

  def date_joined
    created_at.strftime('%b. %d, %Y')
  end

  def authorized?
    platform_admin? || store_admin? || store_manager?
  end

  def self.admins(user)
    if user.authorized?
      left_joins(:roles)
      .where(roles: { name: ["store admin", "store manager" ] })
      .to_a - [user]
    end
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end
end
