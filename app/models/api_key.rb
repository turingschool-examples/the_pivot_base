class ApiKey < ApplicationRecord 
  belongs_to :user

  after_create :generate_key

  private

    def generate_key
      self.key = Digest::SHA512.hexdigest(Time.now.to_s + self.user.email)
    end

end
