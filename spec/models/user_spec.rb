require "rails_helper"

RSpec.describe User, type: :model do
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
  end

  describe "relationships" do
    context "test relationships" do
      it {should belong_to(:store)}
      it {should have_many(:user_roles)}
      it {should have_many(:roles)}
      it {should have_many(:orders)}
    end
  end

  context "it can have one of four roles" do

    it "has a role" do
      user = build(:user)
      role = create(:role, title: "registered_user")
      UserRole.create(user: user, role: role)

      expect(user.registered_user?).to eq true
    end

    it "can be a registered user" do
      user = build(:user)
      role = create(:role, title: "registered_user")
      UserRole.create(user: user, role: role)
      expect(user.registered_user?).to eq true
    end

    it "can be store manager" do
      user = build(:user)
      role = create(:role, title: "store_manager")
      UserRole.create(user: user, role: role)
      expect(user.store_manager?).to eq true
    end

    it "can be a store admin" do
      user = build(:user)
      role = create(:role, title: "store_admin")
      UserRole.create(user: user, role: role)
      expect(user.store_admin?).to eq true
    end

    it "can be a platform admin" do
      user = build(:user)
      role = create(:role, title: "platform_admin")
      UserRole.create(user: user, role: role)
      expect(user.platform_admin?).to eq true
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

  context "class methods" do
    before(:each) do
      @user = create(:user)
      @store =create(:store)
      @item = create(:item, store: @store)
      @order_1 = create(:order, status: 1, user: @user)
      @order_2 = create(:order, status: 1, user: @user)
      @order_3 = create(:order, status: 2, user: @user)
      @order_4 = create(:order, status: 3, user: @user)
      @order_5 = create(:order, status: 1, user: @user)
      @order_6 = create(:order, status: 2, user: @user)

      @order_item1 = create(:order_item, item: @item, order: @order_1, store: @store)

    end

    it "responds to user orders count method" do
      expect(User.user_orders).to eq({@user.email => 6})
    end

    it "responds to quantity of items ordered method" do
      expect(User.user_quantity_of_items_ordered).to eq({@user.email => 1})
    end
  end
end
