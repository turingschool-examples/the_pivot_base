class Chatroom < ApplicationRecord
  has_many :messages
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: true, case_sensitive: false

  extend FriendlyId
  friendly_id :topic, use: :slugged
end
