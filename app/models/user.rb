class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_role_stores
  has_many :stores, through: :user_role_stores
  has_many :roles, through: :user_role_stores
  has_one  :api_key

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

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
