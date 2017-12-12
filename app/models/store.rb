class Store < ApplicationRecord

  has_many :user_role_stores
  has_many :users, through: :user_role_stores

end
