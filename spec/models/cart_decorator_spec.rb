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

  describe "#sub_total" do
    it "calculates the sub_total cost of the items it holds" do

      var = subject.items_with_quantity.map do |item, quantity|
        item.sub_total(quantity)
      end

      expect(var[0]).to eq(200)

    end
  end


  describe "#items_with_quantity" do
    it "returns a hash of item objects and quantity" do
      byebug
      expect(subject.items_with_quantity[item_1]).to eq(2)
      expect(subject.items_with_quantity[item_2]).to eq(3)
    end
  end

end
