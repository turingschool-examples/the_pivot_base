require 'rails_helper'

describe ShippingAddress do
  context "#instance methods" do
    let!(:attrs) {{"street_address"=>"1883 S Glencoe Std",
             "city"=>"Denver",
             "states"=>"CO",
             "postal_code"=>"80222",
             "country"=>"USA",
             "authenticity_token"=>"p0/+2Og8fhcumSg2NHclgbw6zCVE1fgDdzLVFRRNo6GPCr2snP5ItMZQ1sSBgnK8eCLY0pyxSGUOa38Wq652ew==",
             "controller"=>"validation",
             "action"=>"create"}}
    it ".address" do
      ship_address = ShippingAddress.new(attrs)

      expect(ship_address.address).to eq({street: "1883 S Glencoe Std" ,
                                          city: "Denver",
                                          state: "CO",
                                          postal_code: "80222",
                                          country: "USA"})
    end

    context "provides false if any address values are empty" do
      it ".empty_address" do
        address = ({street: "" ,
                    city: "",
                    state: "CO",
                    postal_code: "80222",
                    country: "USA"})

        ship_address = ShippingAddress.new(attrs)

        expect(ship_address.empty_address?(address)).to eq true
      end
    end
    context "provides true if all address values are filled" do
      it ".empty_address" do
        address = ({street: "1883 S Glencoe Std" ,
                    city: "Denver",
                    state: "CO",
                    postal_code: "80222",
                    country: "USA"})

        ship_address = ShippingAddress.new(attrs)

        expect(ship_address.empty_address?(address)).to eq false
      end
    end

    context "provides false if any address values are empty" do
      it ".validate_address" do
        attrs = ({street: "" ,
                    city: "",
                    state: "CO",
                    postal_code: "80222",
                    country: "USA"})

        ship_address = ShippingAddress.new(attrs)

        expect(ship_address.validate_address?).to eq false
      end
    end
    context "provides true if valid address" do
      it ".validate_address" do
        address = ({street: "1883 S Glencoe Std" ,
                    city: "Denver",
                    state: "CO",
                    postal_code: "80222",
                    country: "USA"})

        ship_address = ShippingAddress.new(attrs)

        expect(ship_address.validate_address?).to eq true
      end
    end
  end
end
