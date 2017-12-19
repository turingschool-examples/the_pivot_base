class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.friendly.find(params[:chatroom])
    @message = Message.new
  end
end
