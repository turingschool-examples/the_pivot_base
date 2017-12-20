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
  task run_pending_migrations: :environment do
    load_cmd = "rails db:migrate"
    puts "migrating db"
    puts load_cmd
    system(load_cmd)
  end

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
    Role.create(name: "registered user")
    Role.create(name: "store manager")
    Role.create(name: "store admin")
    Role.create(name: "platform admin")
    Role.create(name: "developer")
  end

  task transfer_role_to_role_table: :environment do
    User.all.each do |user|
      if user.role == 0
        UserRoleStore.create(user: user, role_id: 1)
      elsif user.role == 1
        UserRoleStore.create(user: user, role_id: 4)
      end
    end
  end

  task all: [
              :run_pending_migrations,
              :add_price_to_order_item,
              :create_initial_store_with_items,
              :create_roles_on_role_table,
              :transfer_role_to_role_table
            ]

end

namespace :additional_data do
  task create_stores: :environment do
    Store.create(name: Faker::VentureBros.unique.organization)
    Store.create(name: Faker::VentureBros.unique.organization)
    Store.create(name: Faker::VentureBros.unique.organization)
    Store.create(name: Faker::VentureBros.unique.organization)
    Store.create(name: Faker::VentureBros.unique.organization)
  end

  task create_categories: :environment do
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
    Category.create(title: Faker::Science.unique.element)
  end

  task create_items: :environment do
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-10], store: Store.all[-5])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-9], store: Store.all[-5])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-8], store: Store.all[-4])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-7], store: Store.all[-4])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-6], store: Store.all[-3])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-5], store: Store.all[-3])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-4], store: Store.all[-2])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-3], store: Store.all[-2])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-2], store: Store.all[-1])
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.all[-1], store: Store.all[-1])
    end
  end

  task create_users: :environment do
    User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    josh = User.create(first_name: "Josh", last_name: "Mejia", email: "jmejia@turing.io", password: "password")
    josh.roles << Role.find_by(name: "registered user")
    josh.roles << Role.find_by(name: "store manager")
  end

  task create_orders: :environment do
    5.times do
      Order.create(status: rand(0..3), user: User.all[-5])
    end
    5.times do
      Order.create(status: rand(0..3), user: User.all[-4])
    end
    5.times do
     Order.create(status: rand(0..3), user: User.all[-3])
    end
    5.times do
      Order.create(status: rand(0..3), user: User.all[-2])
    end
    5.times do
      Order.create(status: rand(0..3), user: User.all[-1])
    end
  end

  task create_managers: :environment do
    user1 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user2 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user3 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user4 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user1.roles << Role.find_by(name: "store manager")
    user2.roles << Role.find_by(name: "store manager")
    user3.roles << Role.find_by(name: "store manager")
    user4.roles << Role.find_by(name: "store manager")
  end

  task create_admins: :environment do
    user1 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user2 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user3 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    user4 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    ian = User.create(first_name: "Ian", last_name: "Douglas", email: "ian@turing.io", password: "password")
    user1.roles << Role.find_by(name: "store admin")
    user2.roles << Role.find_by(name: "store admin")
    user3.roles << Role.find_by(name: "store admin")
    user4.roles << Role.find_by(name: "store admin")
    ian.roles << Role.find_by(name: "store admin")
  end

  task create_platform_admin: :environment do
    cory = User.create(first_name: "Cory", last_name: "Westerfield", email: "cory@turing.io", password: "password")
    cory.roles << Role.find_by(name: "platform admin")
  end

  task all: [
              :create_stores,
              :create_categories,
              :create_items,
              :create_users,
              :create_orders,
              :create_managers,
              :create_admins,
              :create_platform_admin
            ]
end
