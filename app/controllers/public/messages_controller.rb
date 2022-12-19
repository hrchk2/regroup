class Public::MessagesController < ApplicationController
  
  def create
      message = current_user.messages.new(message_params)
      if message.save
         redirect_to room_path(message.room)
      else
        redirect_to root_path
      end
  end
  
  private

  def message_params
    params.require(:message).permit(:room_id, :body)
  end

end
