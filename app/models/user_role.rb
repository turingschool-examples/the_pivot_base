class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :store
end
