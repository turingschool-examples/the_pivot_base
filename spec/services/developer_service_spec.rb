require 'rails_helper'

RSpec.describe DeveloperService do
  context "instance methods" do
    it "can register as developer" do
      user = create(:user)
      developer_service = DeveloperService.new(user: user)
      developer_service.register_as_developer

      expect(user.api_key).to_not be(nil)
      expect(user.roles.pluck(:name)).to include("developer")
    end
  end
end
