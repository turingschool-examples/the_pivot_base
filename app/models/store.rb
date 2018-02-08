class Store < ApplicationRecord

  has_many :items 
  validates :name, uniqueness: true 
  validates :slug, uniqueness: true 
  
  before_validation :generate_slug
  
   def generate_slug 
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

end
