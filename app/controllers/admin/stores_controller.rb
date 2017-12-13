class Admin::StoresController < ApplicationController
  def index
    # @pending   = Store.pending
    # @suspended = Store.suspended
    # @active    = Store.active
    @stores = delegate_stores
  end

  def delegate_stores
    return Store.pending   if params[:status] == '0'
    return Store.suspended if params[:status] == '1'
    return Store.active    if params[:status] == '2'
  end
end