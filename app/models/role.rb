class Role < ApplicationRecord
  has_many :store_users
  has_many :users, through: :store_users
end
