class Category < ApplicationRecord
  has_many :items
  validates :title, :url, presence: true

  before_validation :generate_url

  def generate_url
    self.url = title.parameterize if title
  end
end
