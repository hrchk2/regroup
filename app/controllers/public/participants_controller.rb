class Public::ParticipantsController < ApplicationController

  def create
    participant = Participant.new(participant_params)
    post = participant.post
    if post.is_free == true
       participant.approval_status = 1
       participant.save
       redirect_to post_path(participant.post)
    else
       participant.save
       redirect_to post_path(participant.post)
    end
  end
  
  def destroy
    participant = Participant.find(params[:id])
    participant.destroy
    redirect_to post_path(participant.post)
  end

  # オーナー用 参加承認
  def permit
      participant = Participant.find(params[:participant_id])
      participant.approval_status = 2
      participant.save
      redirect_to post_path(participant.post)
  end

  # オーナー用 参加拒否
  def ignore
      participant = Participant.find(params[:participant_id])
      participant.approval_status = 3
      participant.save
      redirect_to post_path(participant.post)
  end

  private
  def participant_params
      params.require(:participant).permit(:user_id,:post_id)
  end

end