class Store < ApplicationRecord
  has_many   :items
  belongs_to :user

  # before_save :add_url
  before_save :generate_slug
  enum status: [ :pending, :active, :suspended ]

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end
  # def add_url
  #   self.url = name.parameterize
  # end

end
