class TweetController < ApplicationController
  before_action :require_admin

  def new; end

  def create
    current_user.send_tweet tweet_params
    redirect_to new_tweet_path
    flash[:success] = "Tweet sent!!"
  end

  private
    def tweet_params
      params.require(:tweet).permit(:message)
    end
end