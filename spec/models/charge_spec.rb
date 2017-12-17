require 'rails_helper'

RSpec.describe Charge, type: :model do
  it { should belong_to(:order) }
  it { should validate_presence_of(:uid) }
end
