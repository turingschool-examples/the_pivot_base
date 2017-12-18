class Admin::StoresController < ApplicationController

  def show
    @store = Store.find_by(url: params[:store_name])
  end

  def edit
    @store = Store.find_by(url: params[:store_name])
    @statuses = Store.statuses.keys
  end
end
