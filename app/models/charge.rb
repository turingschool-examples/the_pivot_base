class Charge < ApplicationRecord
  validates_presence_of :uid
  belongs_to :order
end
