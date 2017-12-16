class User < ApplicationRecord
  has_secure_password
  has_many :orders

  has_many :store_users
  has_many :roles, through: :store_users
  has_many :stores, through: :store_users


  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true


  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def store_manager?
    roles.exists?(name: "store_manager")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
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
