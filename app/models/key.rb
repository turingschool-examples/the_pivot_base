class Key < ApplicationRecord

has_one :user
validates :user_id, presence: true

  def self.create_key(user)
    concat = "#{user.last_name}#{user.email}"
    key =  Digest::MD5.hexdigest(concat)
    Key.create(api_key: key, user_id: user.id)
  end
end 