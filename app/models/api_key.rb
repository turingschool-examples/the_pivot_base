class ApiKey < ApplicationRecord
  validates  :key, presence: true, uniqueness: true
  belongs_to :user
end