class Store < ApplicationRecord

  has_many :store_users
  has_many :users, through: :store_users
  has_many :items
  validates :name, :url, presence: true

  before_validation :generate_url

  enum status: ['pending', 'declined', 'active', 'suspended']

  def generate_url
    self.url = name.parameterize if name
  end
end
