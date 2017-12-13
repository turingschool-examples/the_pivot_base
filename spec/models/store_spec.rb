require 'rails_helper'

RSpec.describe Store, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should define_enum_for(:status) }
  end

  context "relationships" do
    it { should have_many(:user_role_stores) }
    it { should have_many(:users).through(:user_role_stores) }
  end
end