class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :category
  belongs_to :store
  has_many   :order_items
  has_many   :orders, through: :order_items

  has_attached_file :image,
                    :default_url => '/images/missing.jpg',
                    :styles      =>  { thumb: "68x68#", medium: "300x300#" },
                    :path        => ":rails_root/public/images/:id/:style/:filename",
                    :url         => "/images/:id/:style/:filename"

  validates_attachment_content_type :image,content_type: ['image/jpeg',
                                                          'image/jpg',
                                                          'image/gif',
                                                          'image/png']

  enum condition: ["active", "retired"]

  def self.top_3_items
    left_joins(:order_items)
    .group(:id)
    .order('COUNT(order_items.quantity * items.price) DESC')
    .limit(3)
  end

  def self.total_sold_by_item
    group(:title).joins(:order_items).sum(:quantity)
  end

  def self.items_by_title_with_status
    group(:title).joins(:orders).group(:status).count
  end
end
