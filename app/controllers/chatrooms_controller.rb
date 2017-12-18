class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.friendly.find_by(params[:topic])
    @message = Message.new
  end
end
