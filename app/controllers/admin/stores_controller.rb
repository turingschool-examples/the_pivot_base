class Admin::StoresController < ApplicationController
  def index
    @stores = Store.all
  end
end