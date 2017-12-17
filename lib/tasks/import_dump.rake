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
      elsif user.role == 1
        UserRoleStore.create(user: user, role_id: 4)
      end
    end
  end
end


namespace :additional_data do
  task create_stores: :environment do
    stores = []
    5.times { stores << Faker::VentureBros.unique.organization }
    stores.each do |name|
      Store.create(name: name)
    end
  end

  task create_categories: :environment do
    categories = []
    10.times { categories << Faker::Science.unique.element }
    categories.each do |title|
      Category.create(title: title)
    end
  end

  task create_items: :environment do
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(9), store: Store.find(14))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(10), store: Store.find(14))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(11), store: Store.find(15))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(12), store: Store.find(15))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(13), store: Store.find(16))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(14), store: Store.find(16))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(15), store: Store.find(17))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(16), store: Store.find(17))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(17), store: Store.find(18))
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: Category.find(18), store: Store.find(18))
    end
  end

  task create_users: :environment do
    4.times do
      User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    end
    josh = User.create(first_name: "Josh", last_name: "Mejia", email: "email", password: "password")
    josh.roles << Role.find_by(name: "registered_user")
    josh.roles << Role.find_by(name: "store manager")
  end

  task create_orders: :environment do
    5.times do
      Order.create(status: rand(0..3), user: User.find(59))
    end
    5.times do
      Order.create(status: rand(0..3), user: User.find(58))
    end
    5.times do
     Order.create(status: rand(0..3), user: User.find(57))
    end
    5.times do
      Order.create(status: rand(0..3), user: User.find(56))
    end
    5.times do
      Order.create(status: rand(0..3), user: User.find(55))
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
    user5 = User.create(first_name: "Ian", last_name: "Douglas", email: "ian@turing.io", password: "password")
    user1.roles << Role.find_by(name: "store admin")
    user2.roles << Role.find_by(name: "store admin")
    user3.roles << Role.find_by(name: "store admin")
    user4.roles << Role.find_by(name: "store admin")
    user5.roles << Role.find_by(name: "store admin")
  end

  task create_platform_admin: :environment do
    user = User.create(first_name: "Cory", last_name: "Westerfield", email: "cory@turing.io", password: "password")
    user.roles << Role.find_by(name: "platform_admin")
  end
end
