class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price
end
