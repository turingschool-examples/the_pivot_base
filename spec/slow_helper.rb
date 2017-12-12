module SlowHelper
  def create_items
    @category = Category.create(title: "Cats")
    @item = @category.items.create(title: "Black Cat Onesie",
                                   description: "The best cat onesie you'll ever find",
                                   price: 19.99,
                                   image: "https://images-na.ssl-images-amazon.com/images/I/41CFHIae7TL._SL500_.jpg")
  end

  def two_items
    @item_one, @item_two = create_list(:item, 2, category: create(:category))
  end

  def create_orders

    user1 = User.create(first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing")

    order_1 = user1.orders.create(status: "ordered")
    order_1.items << @unicorn_onesie_1
    order_1.items << @giraffe_onesie_1

    user2 = User.create(first_name: "SoTesty", last_name: "DeTest", email:"test@testmail.com", password: "testing")

    order_2 = user2.orders.create(status: "completed")
    order_2.items << @unicorn_onesie_1

    order_3 = user2.orders.create(status: "completed")
    order_3.items << @unicorn_onesie_1
    order_3.items << @giraffe_onesie_1

    user3 = User.create(first_name: "BestTest", last_name: "ReTest", email:"testing@testmail.com", password: "testing")

    order_4 = user3.orders.create(status: "completed")
    order_4.items << @unicorn_onesie_1
  end

  def twelve_items
    description = "Lorem ipsum dolor sit amet, officiis quaerendum eu nam, voluptua deterruisset vix at. In dico sonet aliquip has, eos prima appellantur ea. Omnesque facilisi cu pro. Ut vix brute etiam repudiare. Esse animal explicari ad eam, vis ex oratio ornatus voluptatibus, movet sadipscing ea qui."

    @unicorn = Category.create(title: "Unicorns")
    @squirrel = Category.create(title: "Squirrels")
    @giraffe = Category.create(title: "Giraffes")
    @cat = Category.create(title: "Cats")
    @penguin = Category.create(title: "Penguins")
    @pokemon = Category.create(title: "Pokemon")
    @zebra = Category.create(title: "Zebras")
    @sloth = Category.create(title: "Sloths")

    @unicorn_onesie_1 = @unicorn.items.create(title: "Baby Unicorn",
                                              description: description,
                                              price: 39.99,
                                              image: paperclip_image)

    @unicorn_onesie_2 = @unicorn.items.create(title: "Adult Unicorn",
                                              description: description,
                                              price: 59.99,
                                              image: paperclip_image)

    @squirrel_onesie_1 = @squirrel.items.create(title: "Adult Squirrel - Pink/White",
                                                description: description,
                                                price: 59.99,
                                                image: paperclip_image)

    @squirrel_onesie_2 = @squirrel.items.create(title: "Adult Squirrel - Orange/Black",
                                                description: description,
                                                price: 59.99,
                                                image: paperclip_image)

    @giraffe_onesie_1 = @giraffe.items.create(title: "Adult Giraffe",
                                              description: description,
                                              price: 59.99,
                                              image: paperclip_image)

    @cat_onesie_1 = @cat.items.create(title: "Adult Leopard",
                                      description: description,
                                      price: 49.99,
                                      image: paperclip_image)

    @cat_onesie_2 = @cat.items.create(title: "Adult Tiger",
                                      description: description,
                                      price: 49.99,
                                      image: paperclip_image)

    @penguin_onesie_1 = @penguin.items.create(title: "Adult Penguin",
                                              description: description,
                                              price: 49.99,
                                              image: paperclip_image)

    @pokemon_onesie_1 = @pokemon.items.create(title: "Young Pikachu - Boy",
                                              description: description,
                                              price: 29.99,
                                              image: paperclip_image)

    @pokemon_onesie_2 = @pokemon.items.create(title: "Young Pikachu - Girl",
                                              description: description,
                                              price: 29.99,
                                              image: paperclip_image)

    @zebra_onesie_1 = @zebra.items.create(title: "Adult Zebra",
                                          description: description,
                                          price: 29.99,
                                          image: paperclip_image)

    @sloth_onesie_1 = @sloth.items.create(title: "Adult Sloth",
                                          description: description,
                                          price: 69.99,
                                          image: paperclip_image)

  end

  def setup
    twelve_items
    @user_1 = User.create(first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi")
    @user_2 = User.create(first_name: "Jake", last_name: "the Dog", email: "jake@adventuretime.com", password: "dog")
    @order = Order.create(status: "ordered", user_id: @user_1.id)

    items_hash = {
      @unicorn_onesie_1 => 1,
      @squirrel_onesie_1 => 2
    }

    @order.add(items_hash)
  end

  def more_orders
    setup

    @order_2 = Order.create(status: "paid", user_id: @user_1.id)

    items_hash = {
      @zebra_onesie_1 => 1,
      @sloth_onesie_1 => 1
    }

    @order_2.add(items_hash)

    @order_3 = Order.create(status: "cancelled", user_id: @user_2.id)

    items_hash = {
      @penguin_onesie_1 => 3,
      @pokemon_onesie_1 => 1
    }

    @order_3.add(items_hash)

    @order_4 = Order.create(status: "completed", user_id: @user_2.id)

    items_hash = {
      @cat_onesie_2 => 4,
      @giraffe_onesie_1 => 3
    }

    @order_4.add(items_hash)
  end
end
