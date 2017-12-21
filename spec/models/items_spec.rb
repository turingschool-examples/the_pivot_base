require 'rails_helper'

describe Item do
  let(:category) { build(:category, title: "Animals") }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    it { should_not allow_value(-1).for(:price) }
    it { should_not allow_value(0).for(:price) }
    it { should have_attached_file(:image) }
    it { should define_enum_for(:condition) }
  end

  describe "relationships" do
    it { should belong_to(:category) }
    it { should respond_to(:category) }
    it { should have_many(:orders).through(:order_items) }
    it { should respond_to(:orders) }
    it { should respond_to(:store)}
    it { should belong_to(:store)}
  end
end
