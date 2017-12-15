class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :user_role_stores
  has_many :stores, through: :user_role_stores
  has_many :users, through: :user_role_stores


end
