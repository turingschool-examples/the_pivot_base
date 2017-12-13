class Store < ApplicationRecord
  validates :name, presence: true

  has_many :user_role_stores
  has_many :users, through: :user_role_stores

  enum status: ["pending", "active"]
end
