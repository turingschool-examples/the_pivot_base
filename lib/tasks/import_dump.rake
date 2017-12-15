namespace :import_dump do
  desc "Load pre-generated PG data into Dev db"
  task :load => ["db:drop", "db:create"] do
    load_cmd = "psql -d the_pivot_development -f #{Rails.root.join("backup.sql")}"
    puts "will load Data dump into local PG database with command:"
    puts load_cmd
    system(load_cmd)
  end
end

namespace :import_from_backup do
  desc "load backup as of thursday 12/14 at 11:02 am"
  task :load => ["db:drop", "db:create"] do
    load_cmd = "psql -d the_pivot_development -f #{Rails.root.join("dumper.sql")}"
    puts "will load Data dump into local PG database with command:"
    puts load_cmd
    system(load_cmd)
  end
end

namespace :update_db do
  task add_price_to_order_item: :environment do
    OrderItem.all.each do |order_item|
      price = Item.find(order_item.item_id).price
      order_item.update(price: price)
    end
  end

  task create_initial_store_with_items: :environment do
    store = Store.find_or_create_by(name: "Writ and Wit", status: 2)
    store.save
    Item.all.each do |item|
      item.update(store: store) if item.store == nil
    end
  end


  task create_roles_on_role_table: :environment do
    Role.create(name: "registered_user")
    Role.create(name: "store manager")
    Role.create(name: "store admin")
    Role.create(name: "platform_admin")
    Role.create(name: "developer")
  end

  task transfer_role_to_role_table: :environment do
    User.all.each do |user|
      if user.role == 0
        UserRoleStore.create(user: user, role_id: 1)
      else
        UserRoleStore.create(user: user, role_id: 4)
      end
    end
  end
end
