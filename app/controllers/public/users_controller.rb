class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:quit,:withdraw,:drafts,:notifications]
  before_action :ensure_guest_user, only: [:edit,:update,:quit,:withdraw,:drafts,:notifications]

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
    @posts = Post.where(user_id: @user.id,status: 0)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def quit
    @user = User.find(params[:id])
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites
      @user = User.find(params[:id])
      favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
      @favorite_posts = Post.find(favorites)
  end

  def drafts
      @user = User.find(params[:id])
      @posts = Post.where(user_id: @user.id,status: 1)
  end

  def notifications
      ensure_correct_user
      @posts = Post.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction,:email,:profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless  @user == current_user
      redirect_to user_path(current_user), notice: 'ユーザーが正しくありません。'
    end
  end


  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーは遷移できません。'
    end
  end

end