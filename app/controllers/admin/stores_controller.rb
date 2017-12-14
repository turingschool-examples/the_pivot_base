class Admin::StoresController < ApplicationController
  before_action :authorize!

  def index
    @stores = delegate_stores
  end

  def show
    @store = Store.find(params[:id])
  end

  def delegate_stores
    return Store.all       if !params[:status]
    return Store.pending   if params[:status] == '0'
    return Store.suspended if params[:status] == '1'
    return Store.active    if params[:status] == '2'
  end

  def update
    @store = Store.find(params[:id])
    if @store.pending?
      status = params[:status]
      @store.update(status: status)
      if @store.save
        flash[:success] = "#{@store.name} marked as #{status}"
        redirect_to admin_stores_path
      end
    end
  end
end