class Admin::AnalyticsController < ApplicationController
  # before_action :require_admin

  def index
    @analytics = AdminAnalyticsPresenter.new
  end

  # private
  #   def require_admin
  #     render file: "/public/404" unless current_store_admin?
  #   end

end
