class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_role_stores
  has_many :stores, through: :user_role_stores
  has_many :roles, through: :user_role_stores
  has_one  :api_key

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |user|
      user.uid                = auth_info.uid
      user.first_name         = auth_info.extra.raw_info.name.split[0]
      user.last_name          = auth_info.extra.raw_info.name.split[1]
      user.screen_name        = auth_info.extra.raw_info.screen_name
      user.oauth_token        = auth_info.credentials.token
      user.oauth_token_secret = auth_info.credentials.secret
      user.email              = auth_info.extra.raw_info.screen_name
      user.password           = 'i_heart_burritos'
      user.save!
    end
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

  def full_name
    first_name + " " + last_name
  end

  def date_joined
    created_at.strftime('%b. %d, %Y')
  end

  def authorized?
    platform_admin? || store_admin? || store_manager?
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end
end