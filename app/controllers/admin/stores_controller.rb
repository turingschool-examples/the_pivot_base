class Admin::StoresController < ApplicationController
  before_action :require_admin
  def index
    binding.pry
    @stores = []
    @stores << Store.where(status: 'pending') if params[:query] == 'pending' || params[:query].nil?
    @stores << Store.where(status: 'active') if params[:query] == 'active'
    @stores << Store.where(status: 'suspended') if params[:query] == 'suspended'
  end
end