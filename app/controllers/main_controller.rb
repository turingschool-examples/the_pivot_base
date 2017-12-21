class MainController < ApplicationController
  def index
    #@popular_items = OrderItem.top_three_items
    @popular_items = Item.all.limit(5)
  end
end
