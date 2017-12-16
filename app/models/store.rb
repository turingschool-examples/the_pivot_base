class Store < ApplicationRecord
<<<<<<< HEAD
  has_many :user_roles
  has_many :users, through: :user_roles
=======
  has_many :store_users
  has_many :users, through: :store_users
>>>>>>> development
  has_many :store_items
  has_many :items, through: :store_items
end
