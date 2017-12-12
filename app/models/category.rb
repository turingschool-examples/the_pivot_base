class Category < ApplicationRecord
  validates :title, :slug, presence: true
  has_many  :items

  extend FriendlyId
  friendly_id :title, use: :slugged
end