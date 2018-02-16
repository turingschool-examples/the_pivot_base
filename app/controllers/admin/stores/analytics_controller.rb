class Admin::Stores::AnalyticsController < ApplicationController
  # before_action :require_admin

  def index
    @store = Store.find_by(slug: params[:store])
    @analytics = StoreAdminAnalyticsPresenter.new(@store)
  end

end
