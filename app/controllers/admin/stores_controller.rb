class Admin::StoresController < ApplicationController
  def index
    # @pending   = Store.pending
    # @suspended = Store.suspended
    # @active    = Store.active
    @stores = Store.all
  end
end