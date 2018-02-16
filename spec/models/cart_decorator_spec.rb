require 'rails_helper'

RSpec.describe CartDecorator do
  let(:item_1) { create(:item, price: 100.00) }
  let(:item_2) { create(:item, price: 100.00) }

  let(:cart) { Cart.new({"#{item_1.id}" => 2,  "#{item_2.id}" => 3})}

  subject {CartDecorator.new(cart)}

  describe "#total" do
    it "calculates the total cost of the items it holds" do
      expect(subject.total).to eq(500)
    end
  end

describe "#items" do
  it "can make an array of CartItems" do

    expect(subject.items.count).to eq(2)
    expect(subject.items[1].item.description).to eq("Dead dove. Do not eat.")
    expect(subject.items[1].item.price).to eq(100)

    expect(subject.items[1].quantity).to eq(3)
  end
end




end
