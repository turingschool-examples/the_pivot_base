require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:user_role_stores) }
  it { should have_many(:users) }
end
