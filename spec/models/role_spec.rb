require 'rails_helper'

RSpec.describe Role, type: :model do
  it "has the required attributes" do 
    role = create(:role)

    expect(role.title).to eq(role.title)
  end

end
