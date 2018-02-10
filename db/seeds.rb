class Seed

  def self.run
    new.run
  end

  music_store = Store.create(name: "Music Store")
  little_shop_og = Store.create(name: "Little Shop OG")

  role1 = Role.create(title: "platform_admin")
  role2 = Role.create(title: "store_admin")
  role3 = Role.create(title: "store_manager")
  role4 = Role.create(title: "registered_user")



  def run
    associate_items_with_stores
    associate_users_with_stores
    associate_users_with_roles
    associate_cloud_image_to_items
  end


  def associate_items_with_stores
    Item.all.each do |item|
      item.update(store_id: 2)
    end
  end

  def associate_users_with_stores
    User.all.each do |user|
      user.update(store_id: 2, password: "password")
    end
  end


  def associate_cloud_image_to_items
    Item.all.each do |item|
      item.update(image: 'http://res.cloudinary.com/le-pivot/image/upload/v1518274406/book_cover.png')
    end
  end


  def associate_users_with_roles
    User.all.each do |user|
      if user.role == "default"
        UserRole.create(user: user, role: Role.find(4))
      else user.role == "admin"
        UserRole.create(user: user, role: Role.find(2))
      end
    end
  end
end

Seed.run
