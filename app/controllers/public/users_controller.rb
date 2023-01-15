class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:quit,:withdraw,:drafts,:notifications,:joinings]
  before_action :ensure_guest_user, only: [:edit,:update,:quit,:withdraw,:drafts,:notifications,:favorites,:joinings]

  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @posts = Post.where(user_id: @user.id,status: 0).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def quit
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page])
  end

  def drafts
    @posts = Post.where(user_id: @user.id,status: 1).page(params[:page])
  end

  def notifications
    @posts =  @user.posts.includes(:participants).distinct
    @new_posts = @posts.where(participants: {approval_status: 0})
    @new_posts_paticipants_count = @new_posts.group(:post_id).count.values.sum
    @cancel_posts = @posts.where(participants: {approval_status: 2})
    @cancel_posts_paticipants_count = @cancel_posts.group(:post_id).count.values.sum
  end
  
  def joinings
    @posts = Post.includes(:participants).distinct
    @joining_posts = @posts.where(participants: {user_id: @user,approval_status: 1}).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction,:email,:profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless  @user == current_user
      flash[:user_error]= "ユーザーが正しくありません。"
      redirect_to user_path(current_user)
    end
  end


  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
       flash[:user_error]= 'ゲストユーザーは遷移できません。'
      redirect_to user_path(current_user)
    end
  end
  
end