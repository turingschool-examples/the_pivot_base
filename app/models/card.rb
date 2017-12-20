class Card < ApplicationRecord
  validates_presence_of :uid
  belongs_to :user
end
