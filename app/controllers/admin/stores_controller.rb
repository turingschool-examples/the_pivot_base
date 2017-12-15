class Admin::StoresController < ApplicationController
  before_action :authorize!

  def index
    @stores = delegate_stores
  end

  def show
    @store = Store.find(params[:id])
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

  private
  
    def delegate_stores
      if params[:status]
        Store.where(status: params[:status])
      else
        Store.all
      end
    end

end
