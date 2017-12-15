require 'rails_helper'

RSpec.describe UserRoleStore, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:role) }
  it { should belong_to(:store) }
end
