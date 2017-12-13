class Store < ApplicationRecord
  validates :name, presence: true

  has_many :user_role_stores
  has_many :users, through: :user_role_stores

  enum status: %w(pending suspended active)

  def self.pending
    where(status: 'pending')
  end

  def self.suspended
    where(status: 'suspended')
  end

  def self.active
    where(status: 'active')
  end
end
