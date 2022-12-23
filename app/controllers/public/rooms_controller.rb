class Public::RoomsController < ApplicationController
  
  before_action :ensure_correct_user, only: [:index,:create,:show]
  before_action :ensure_guest_user, only: [:index,:create,:show]

  def index
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # 自分のentryを配列で出す。このままだと自分の情報も出るのでwhere.notで外す
    @entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end

  private

  def ensure_correct_user
    @room = Room.find(params[:id])
    @entry = @room.entries.find_by(user_id: current_user.id)
    unless @entry.user == current_user
      redirect_to user_path(current_user), notice: 'ユーザーが正しくありません。'
    end
  end


  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーは遷移できません。'
    end
  end

end
