class MainController < ApplicationController
  def index
    @popular_items = Item.top_3_items
  end
end
