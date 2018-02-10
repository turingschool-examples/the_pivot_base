class Seed

  def self.run
    new.run
  end


  def run
    associate_items_with_stores
    associate_users_with_stores
    # associate_users_with_roles
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
