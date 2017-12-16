class Store < ApplicationRecord

  has_many :store_users
  has_many :users, through: :store_users
  has_many :store_items
  has_many :items, through: :store_items
end
