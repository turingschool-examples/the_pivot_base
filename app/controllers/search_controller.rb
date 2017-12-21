class SearchController < ApplicationController
  def index
    ransacked = Item.ransack(title_or_description_cont: params['live-search'])
    @items    = ransacked.result(distinct: true)
    redirect_to item_path(@items.first) if @items.length == 1
  end
end
