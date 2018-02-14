class Role < ApplicationRecord
  has_many :users
  has_many :users, through: :user_roles


end
