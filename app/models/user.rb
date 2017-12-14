class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_role_stores
  has_many :stores, through: :user_role_stores
  has_many :roles, through: :user_role_stores
  has_one :api_key

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: ["default", "admin"]

  def platform_admin?
    roles.exists?(name: 'platform_admin')
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

  def developer?
    roles.pluck(:name).include?("developer")
  end

end
