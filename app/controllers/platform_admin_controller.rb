class PlatformAdminController < ApplicationController

  def index
    @stores = Store.all
  end

end
