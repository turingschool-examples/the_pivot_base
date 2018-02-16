class User < ApplicationRecord
  has_secure_password
  has_many :orders

  belongs_to :store, optional: true
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, on: :create
  validates :email, presence: true

  # Now need to validate address. Could validate via EasyPost on account creation.
  # Need to parse the phone number (could be 719-9648875, or 719.964.8875, or something else. Need to check for and reject bad numbers?)
  # also need to validate zip codes before saving.

  # enum role: ["default", "admin"]

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

  def registered_user?
    roles.exists?(title: "registered_user")
  end

  def store_manager?
    roles.exists?(title: "store_manager")
  end

  def store_admin?
    roles.exists?(title: "store_admin")
  end

  def platform_admin?
    roles.exists?(title: "platform_admin")
  end
end
