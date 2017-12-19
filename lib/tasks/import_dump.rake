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
    @store1 = Store.create(name: Faker::VentureBros.unique.organization)
    @store2 = Store.create(name: Faker::VentureBros.unique.organization)
    @store3 = Store.create(name: Faker::VentureBros.unique.organization)
    @store4 = Store.create(name: Faker::VentureBros.unique.organization)
    @store5 = Store.create(name: Faker::VentureBros.unique.organization)
  end

  task create_categories: :environment do
    @category1 = Category.create(title: Faker::Science.unique.element)
    @category2 = Category.create(title: Faker::Science.unique.element)
    @category3 = Category.create(title: Faker::Science.unique.element)
    @category4 = Category.create(title: Faker::Science.unique.element)
    @category5 = Category.create(title: Faker::Science.unique.element)
    @category6 = Category.create(title: Faker::Science.unique.element)
    @category7 = Category.create(title: Faker::Science.unique.element)
    @category8 = Category.create(title: Faker::Science.unique.element)
    @category9 = Category.create(title: Faker::Science.unique.element)
    @category10 = Category.create(title: Faker::Science.unique.element)
  end

  task create_items: :environment do
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category1, store: @store1)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category2, store: @store1)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category3, store: @store2)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category4, store: @store2)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category5, store: @store3)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category6, store: @store3)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category7, store: @store4)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category8, store: @store4)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category9, store: @store5)
    end
    5.times do
      Item.create(title: Faker::Hipster.unique.word, description: Faker::Hipster.unique.sentence, price: rand(5.00..100.00).round(2), category: @category10, store: @store5)
    end
  end

  task create_users: :environment do
    @user1 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    @user2 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    @user3 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    @user4 = User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, email: Faker::Internet.unique.email, password: "password")
    @josh = User.create(first_name: "Josh", last_name: "Mejia", email: "jmejia@turing.io", password: "password")
    @josh.roles << Role.find_by(name: "registered_user")
    @josh.roles << Role.find_by(name: "store manager")
  end

  task create_orders: :environment do
    5.times do
      Order.create(status: rand(0..3), user: @user1)
    end
    5.times do
      Order.create(status: rand(0..3), user: @user2)
    end
    5.times do
     Order.create(status: rand(0..3), user: @user3)
    end
    5.times do
      Order.create(status: rand(0..3), user: @user4)
    end
    5.times do
      Order.create(status: rand(0..3), user: @josh)
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
    cory.roles << Role.find_by(name: "platform_admin")
  end
end
