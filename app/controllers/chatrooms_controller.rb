class ChatroomsController < ApplicationController

  def show
    if current_user
      @chatroom = Chatroom.friendly.find(params[:chatroom])
      @message = Message.new
    else
      render file: "/public/404"
    end
  end
end
