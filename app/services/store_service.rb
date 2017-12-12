module StoreService

  def self.create_proposed_store(user, store_name)
    if store = Store.create(name: name)
      role = Role.find_or_create_by(name: "store_admin")
      UserRoleStore.create(user: user, store: store, role: role)
    end
  end

end
