class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(twitter_params[:message])
    redirect_to tweets_new_path
    flash[:success] = "Tweet succesfully sent!"
  end

  private

    def twitter_params
      params.require(:tweet).permit(:message)
    end
end