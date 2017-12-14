class Role < ApplicationRecord
  validates_presence_of :name

  has_many :user_role_stores
  has_many :user_roles
  has_many :stores, through: :user_role_stores
  has_many :users,  through: :user_role_stores

end
