require "rails_helper"

describe "validations" do
  context "invalid attributes" do

    it "is invalid without a first name" do
      user = build(:user, first_name: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a last name" do
      user = build(:user, last_name: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it "is invalid without an e-mail" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a unique e-mail" do
      user_1 = create(:user, email: "gob@example.com")
      user_2 = build(:user, email: "gob@example.com")
      expect(user_2).to be_invalid
    end
  end

  context "it can have one of four roles" do

    it "has a role" do
      user = build(:user)
      role4 = Role.create(title: "registered_user")
      UserRole.create(user: user, role: role4)
      expect(user.roles.first.title).to eq("registered_user")
    end

    it "can be a registered user" do
      user = build(:user)
      role4 = Role.create(title: "registered_user")
      UserRole.create(user: user, role: role4)
      expect(user.roles.first.title).to eq("registered_user")
    end

    it "can be business manager" do
      user = build(:user)
      role = Role.create(title: "store_manager")
      UserRole.create(user: user, role: role)
      expect(user.roles.first.title).to eq("store_manager")
    end

    it "can be a store admin" do
      user = build(:user)
      role4 = Role.create(title: "store_admin")
      UserRole.create(user: user, role: role4)
      expect(user.roles.first.title).to eq("store_admin")
    end

    it "can be a platform admin" do
      user = build(:user)
      role4 = Role.create(title: "platform_admin")
      UserRole.create(user: user, role: role4)
      expect(user.roles.first.title).to eq("platform_admin")
    end


  end

  context "instance methods" do
    it "can return user's full name" do
      user = User.new(first_name: "McTest",last_name: "McTest", password: "testing", email: "tester@testmail")
      expect(user.full_name).to eq("McTest McTest")
    end

    it "can return the date a user joined" do
      user = User.create(first_name: "McTest",last_name: "McTest", password: "testing", email: "tester@testmail", created_at: "2017-09-13 01:13:04 -0600")
      expect(user.date_joined).to eq("Sep. 13, 2017")
    end
  end
end
