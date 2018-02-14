require 'rails_helper'

RSpec.feature "Admin Orders" do

  # let(:admin) { create(:store_admin) }
  # let(:store) { create(:store)}
  # let(:user) { create(:user, store: store) }
  # let(:role) { create(:role, title: "store_admin")}
  # let(:user_role) {create(:user_role, user: user, role: role)}

  context "As an admin and two orders in the database" do
    let!(:order_1) { create(:order, status: "ordered") }
    let!(:order_2) { create(:order) }

    it "I can see the total number of orders for each status" do
      store = create(:store)
      admin = create(:store_admin, store: store)
      role = Role.create(title: "store_admin")
      create(:user_role, user: admin, role: role)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_store_dashboard_index_path(store)

      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_1.date)
      expect(page).to have_content(order_1.status.capitalize)
    end

    it "I can see orders filtered by status" do
      store = create(:store)
      admin = create(:store_admin, store: store)
      role = Role.create(title: "store_admin")
      create(:user_role, user: admin, role: role)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_store_dashboard_index_path(store)

      click_on("Ordered")

      expect(current_path).to eq(admin_store_dashboard_index_path(store))
      expect(page).to have_link(order_1.id, href: order_path(order_1))
      expect(page).not_to have_link(order_2.id)


    end

    it "I can change the status of orders" do
      store = create(:store)
      admin = create(:store_admin, store: store)
      role = Role.create(title: "store_admin")
      create(:user_role, user: admin, role: role)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_store_dashboard_index_path(store)

      within(".order-#{order_2.id}") do
        click_on("Cancel")
      end

      expect(current_path).to eq(admin_store_dashboard_index_path(store))

      within(".order-#{order_2.id}") do
        expect(page).to have_content("Cancelled")
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Paid")
      end

      expect(current_path).to eq(admin_store_dashboard_index_path(store))

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Paid")
        end
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Completed")
      end

      expect(current_path).to eq(admin_store_dashboard_index_path(store))

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Completed")
        end
      end
    end
  end
end
