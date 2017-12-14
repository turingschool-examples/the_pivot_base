class Store < ApplicationRecord
  validates :name, :slug, presence: true

  has_many :items
  has_many :user_role_stores
  has_many :users, through: :user_role_stores
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum status: %w(pending suspended active)

  def self.total_pending
    where(status: 0).count
  end

  def self.total_suspended
    where(status: 1).count
  end

  def self.total_active
    where(status: 2).count
  end
end
