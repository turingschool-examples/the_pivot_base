class Store < ApplicationRecord
	has_many   :items
	belongs_to :user

	before_save :add_url

	def add_url
		self.url = name.parameterize
	end 	
end
