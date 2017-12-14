require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  context "validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
  end

end
