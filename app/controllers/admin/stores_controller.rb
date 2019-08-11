class Admin::StoresController < ApplicationController

  def show
    @store = Store.find_by(url: params[:store_name])
  end
end
