class StoreItemPresenter

  attr_reader :store

  def initialize(store)
    @store = store
  end

  def items
    store.items
  end

end
