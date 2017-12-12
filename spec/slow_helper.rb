module SlowHelper
  def create_items
    @category = create(:category, title: "Cats")
    @item = create(:item, category_id: @category.id, title: "Black Cat Onesie",
                                   description: "The best cat onesie you'll ever find",
                                   price: 19.99,
                                   image: "https://images-na.ssl-images-amazon.com/images/I/41CFHIae7TL._SL500_.jpg")
  end

  def two_items
    @one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
    @two_url = "https://cdn.shopify.com/s/files/1/0768/3211/products/eeyore-kigurumi-onesie-sazac-23866341901_2048x2048_61d2ab59-04ea-4a67-a997-b6443780a1c9_2048x2048.jpg?v=1500604859"
    @category = create(:category, title: "Animals")
    @item_one = create(:item, category_id: @category.id, title: "Funsie Onesie", description: "number one", price: 8.00,
                                       image: @one_url )
    @item_two = create(:item, category_id: @category.id, title: "Funsie Twosie", description: "too awesome", price: 12.00,
                                       image: @two_url )
  end

  def create_orders

    user1 = create(:user, first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing")

    order_1 = create(:order, user_id: user1.id, status: "ordered")
    order_1.items << @unicorn_onesie_1
    order_1.items << @giraffe_onesie_1

    user2 = create(:user, first_name: "SoTesty", last_name: "DeTest", email:"test@testmail.com", password: "testing")

    order_2 = create(:order, user_id: user_2.id, status: "completed")
    order_2.items << @unicorn_onesie_1

    order_3 = create(:order, user_id: user_2.id, status: "completed")
    order_3.items << @unicorn_onesie_1
    order_3.items << @giraffe_onesie_1

    user3 = create(:user, first_name: "BestTest", last_name: "ReTest", email:"testing@testmail.com", password: "testing")

    order_4 = create(:order, user_id: user3.id, status: "completed")
    order_4.items << @unicorn_onesie_1
  end

  def twelve_items
    description = "Lorem ipsum dolor sit amet, officiis quaerendum eu nam, voluptua deterruisset vix at. In dico sonet aliquip has, eos prima appellantur ea. Omnesque facilisi cu pro. Ut vix brute etiam repudiare. Esse animal explicari ad eam, vis ex oratio ornatus voluptatibus, movet sadipscing ea qui."

    @unicorn = create(:category, title: "Unicorns")
    @squirrel = create(:category, title: "Squirrels")
    @giraffe = create(:category, title: "Giraffes")
    @cat = create(:category, title: "Cats")
    @penguin = create(:category, title: "Penguins")
    @pokemon = create(:category, title: "Pokemon")
    @zebra = create(:category, title: "Zebras")
    @sloth = create(:category, title: "Sloths")

    @unicorn_onesie_1 = create(:item, category_id: @unicorn.id, title: "Baby Unicorn",
                                              description: description,
                                              price: 39.99,
                                              image: paperclip_image)

    @unicorn_onesie_2 = create(:item, category_id: @unicorn.id, title: "Adult Unicorn",
                                              description: description,
                                              price: 59.99,
                                              image: paperclip_image)

    @squirrel_onesie_1 = create(:item, category_id: @squirrel.id, title: "Adult Squirrel - Pink/White",
                                                description: description,
                                                price: 59.99,
                                                image: paperclip_image)

    @squirrel_onesie_2 = create(:item, category_id: @squirrel.id, title: "Adult Squirrel - Orange/Black",
                                                description: description,
                                                price: 59.99,
                                                image: paperclip_image)

    @giraffe_onesie_1 = create(:item, category_id: @giraffe.id, title: "Adult Giraffe",
                                              description: description,
                                              price: 59.99,
                                              image: paperclip_image)

    @cat_onesie_1 = create(:item, category_id: @cat.id, title: "Adult Leopard",
                                      description: description,
                                      price: 49.99,
                                      image: paperclip_image)

    @cat_onesie_2 = create(:item, category_id: @cat.id, title: "Adult Tiger",
                                      description: description,
                                      price: 49.99,
                                      image: paperclip_image)

    @penguin_onesie_1 = create(:item, category_id: @penguin.id, title: "Adult Penguin",
                                              description: description,
                                              price: 49.99,
                                              image: paperclip_image)

    @pokemon_onesie_1 = create(:item, category_id: @pokemon.id, title: "Young Pikachu - Boy",
                                              description: description,
                                              price: 29.99,
                                              image: paperclip_image)

    @pokemon_onesie_2 = create(:item, category_id: @pokemon.id, title: "Young Pikachu - Girl",
                                              description: description,
                                              price: 29.99,
                                              image: paperclip_image)

    @zebra_onesie_1 = create(:item, category_id: @zebra.id, title: "Adult Zebra",
                                          description: description,
                                          price: 29.99,
                                          image: paperclip_image)

    @sloth_onesie_1 = create(:item, category_id: @sloth.id, title: "Adult Sloth",
                                          description: description,
                                          price: 69.99,
                                          image: paperclip_image)

  end

  def setup
    twelve_items
    @user_1 = create(:user, first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi")
    @user_2 = create(:user, first_name: "Jake", last_name: "the Dog", email: "jake@adventuretime.com", password: "dog")
    @order = create(:order, status: "ordered", user_id: @user_1.id)

    items_hash = {
      @unicorn_onesie_1 => 1,
      @squirrel_onesie_1 => 2
    }

    @order.add(items_hash)
  end
  def more_orders
    setup

    @order_2 = create(:order, status: "paid", user_id: @user_1.id)

    items_hash = {
      @zebra_onesie_1 => 1,
      @sloth_onesie_1 => 1
    }

    @order_2.add(items_hash)

    @order_3 = create(:order, status: "cancelled", user_id: @user_2.id)

    items_hash = {
      @penguin_onesie_1 => 3,
      @pokemon_onesie_1 => 1
    }

    @order_3.add(items_hash)

    @order_4 = create(:order, status: "completed", user_id: @user_2.id)

    items_hash = {
      @cat_onesie_2 => 4,
      @giraffe_onesie_1 => 3
    }

    @order_4.add(items_hash)
  end
end
