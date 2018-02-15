class Seed

  def self.run
    new.run
  end

  comic_store = Store.create(name: "Astropia Comics")
  little_shop_og = Store.create(name: "Little Shoppe OG")
  movie_store = Store.create(name: "Film-O-Phile")
  manga_store = Store.create(name: "Manga Mania")
  tv_show_store = Store.create(name: "Couch Potato Nirvana")

  role1 = Role.create(title: "platform_admin")
  role2 = Role.create(title: "store_admin")
  role3 = Role.create(title: "store_manager")
  role4 = Role.create(title: "registered_user")



  def run
    associate_items_with_stores
    associate_users_with_stores
    associate_users_with_roles
    associate_cloud_image_to_items
    fill_order_items
    update_orders_with_totals
  end


  def associate_items_with_stores
    Item.first(1011).each do |item|
      item.update(store_id: 2)
    end
  end

  def associate_users_with_stores
    User.first(54).each do |user|
      user.update(store_id: 2, password: "password")
    end
  end


  def associate_cloud_image_to_items
    Item.first(1011).each do |item|
      item.update(image: 'http://res.cloudinary.com/le-pivot/image/upload/v1518274406/book_cover.png')
    end
  end


  def associate_users_with_roles
    User.first(54).each do |user|
      if user.role == "default"
        UserRole.create(user: user, role: Role.find(4))
      else user.role == "admin"
        UserRole.create(user: user, role: Role.find(2))
      end
    end
  end


  def fill_order_items
    OrderItem.all.each do |order_item|
      item = Item.find(order_item.item_id)
      order_item.update(store_id: item.store_id, unit_price: item.price)
    end
  end


  def update_orders_with_totals
    Order.all.each do |order|
      order_total = OrderItem.where(order_id: order.id).map{|oi| oi.unit_price * oi.quantity}.sum
      order.update(total: order_total)

    end
  end


  urban_fiction = Category.create(title: "Urban Fiction")
  romance = Category.create(title: "Romance")
  satire = Category.create(title: "Satire")
  mythology = Category.create(title: "Mythology")
  adventure = Category.create(title: "Adventure")
  drama = Category.create(title: "Drama")
  non_fiction = Category.create(title: "Non Fiction")
  historical = Category.create(title: "Historical")
  cartoon = Category.create(title: "Cartoon")
  science_fiction = Category.create(title: "Science Fiction")

  image = "http://res.cloudinary.com/le-pivot/image/upload/v1518286168/tarwjgjz81rlbgvveyrb.png"


  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: urban_fiction.id, store_id: comic_store.id  )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: romance.id, store_id: little_shop_og.id  )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: satire.id, store_id: movie_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: mythology.id, store_id: manga_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: adventure.id, store_id: tv_show_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: drama.id, store_id: comic_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: non_fiction.id, store_id: little_shop_og.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: historical.id, store_id: movie_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: cartoon.id, store_id: manga_store.id )
  end

  5.times do
    Item.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, price: Faker::Commerce.price, image: image, category_id: science_fiction.id, store_id: tv_show_store.id )
  end

  user1 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password, address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}", email: Faker::Internet.email)
  UserRole.create(user: user1, role: role4)
  user2 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password, address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}", email: Faker::Internet.email)
  UserRole.create(user: user2, role: role4)
  user3 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password, address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}", email: Faker::Internet.email)
  UserRole.create(user: user3, role: role4)
  user4 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password, address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}", email: Faker::Internet.email)
  UserRole.create(user: user4, role: role4)
  user5 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password, address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}", email: Faker::Internet.email)
  UserRole.create(user: user5, role: role4)

  order1 = Order.create(user: user1, status: "paid")
  order2 = Order.create(user: user1, status: "completed")
  order3 = Order.create(user: user2, status: "paid")
  order4 = Order.create(user: user2, status: "completed")
  order5 = Order.create(user: user2, status: "ordered")

  order6 = Order.create(user: user3, status: "paid")
  order7 = Order.create(user: user3, status: "completed")
  order8 = Order.create(user: user4, status: "paid")
  order9 = Order.create(user: user4, status: "completed")
  order10 = Order.create(user: user5, status: "ordered")

  josh1 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: comic_store)
  josh2 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: little_shop_og)
  josh3 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: movie_store)
  josh4 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: manga_store)
  josh5 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: tv_show_store)

  UserRole.create(user: josh1, role: role3)
  UserRole.create(user: josh2, role: role3)
  UserRole.create(user: josh3, role: role3)
  UserRole.create(user: josh4, role: role3)
  UserRole.create(user: josh5, role: role3)

ian3 = User.create(first_name: "Ian", last_name: "Mejia", email: "ian@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: movie_store)
ian4 = User.create(first_name: "Ian", last_name: "Mejia", email: "ian@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: manga_store)
ian5 = User.create(first_name: "Ian", last_name: "Mejia", email: "ian@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202", store: tv_show_store)

  UserRole.create(user: ian1, role: role2)
  UserRole.create(user: ian2, role: role2)
  UserRole.create(user: ian3, role: role2)
  UserRole.create(user: ian4, role: role2)
  UserRole.create(user: ian5, role: role2)

  cory = User.create(first_name: "Cory", last_name: "Westerfield", email: "cory@turing.io", password: "password", address: "Turing", address_2: "1331 17th street", city: "Denver", state: "CO", zip: "80202")
  UserRole.create(user: corey, role: role1)

end




Seed.run
