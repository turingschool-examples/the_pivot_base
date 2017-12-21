require "rails_helper"

RSpec.describe User do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe "relationships" do
    it { should have_many(:orders) }
    it { should respond_to(:orders) }
  end

  describe "instance methods" do
    it "can return user's full name" do
      user = User.new(first_name: "McTest",
                      last_name: "McTest",
                      password: "testing",
                      email: "tester@testmail")

      expect(user.full_name).to eq("McTest McTest")
    end

    it "can return the date a user joined" do
      user = User.new(first_name: "McTest",
                      last_name: "McTest",
                      password: "testing",
                      email: "tester@testmail",
                      created_at: "2017-09-13 01:13:04 -0600")

      expect(user.date_joined).to eq("Sep. 13, 2017")
    end
  end
end
