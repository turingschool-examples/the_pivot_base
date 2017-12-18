class Admin::OrdersController < ApplicationController

  def index
    @store = current_user.stores.find_by(url: params[:store_name])
  end
end
