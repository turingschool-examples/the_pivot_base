class ApiKey < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  belongs_to :user

  before_create :generate_key

  private

    def generate_key
      sha512 = OpenSSL::Digest::SHA512.new
      self.key = sha512.digest(Time.now.to_s, self.user.email)
    end

end
