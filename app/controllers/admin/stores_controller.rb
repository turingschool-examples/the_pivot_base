class Admin::StoresController < ApplicationController
  before_action :require_admin
  def index
    @stores_pending = Store.where(status: 'pending')
    @stores_active = Store.where(status: 'active')
    @stores_suspended = Store.where(status: 'suspended')
  end
end