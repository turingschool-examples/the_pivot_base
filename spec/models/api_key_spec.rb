require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  context "validations" do
    it { should belong_to(:user) }
  end

  context "creation" do
    it "will generate api key" do
      user = create(:user)
      api_key = user.create_api_key

      expect(api_key.key).to_not be(nil)
    end
  end
end
