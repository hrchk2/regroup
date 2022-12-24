class Public::MessagesController < ApplicationController

  def create
      message = current_user.messages.new(message_params)
      if message.save
         redirect_to room_path(message.room)
      else
        flash[:dm_error] = "２文字以上入力してください。"
        redirect_to request.referer
      end
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :body)
  end

end
