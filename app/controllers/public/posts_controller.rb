class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]
  before_action :ensure_guest_user, only: [:new,:create,:edit,:update,:destroy]
  
  
  def new
    @post = Post.new
  end

  def index
    @posts =Post.where(status: 0).page(params[:page])
  end

  def create
    @post =current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post =Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
    @participant = Participant.new
    #参加申請中の人
    @participants = @post.participants.where(approval_status: 0 )
    #参加中
    @join = @post.participants.where(approval_status: 1 )
    # キャンセル待ち
    @wait = @post.participants.where(approval_status: 2)
    # 参加しているかどうか
    @member = Participant.find_by(user_id: current_user.id,post_id: @post.id)
    # 参加中の人がキャパと同じかそれ以上の時、募集をストップ
    if @post.capacity == 0
    elsif @join.count >= @post.capacity
       @post.update(is_stop: true)
    else @join.count < @post.capacity
       @post.update(is_stop: false)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to post_path(@post)
    else
       render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def tag
    # @user = current_user
    @tag = Tag.find_by(name: params[:name])
    # tagを削除すると検索時エラーがかかるのでかわりのif文
    if @tag
       @posts = @tag.posts.where(status: 0 ).page(params[:page])
    else
    end
  end

  private
  def post_params
      params.require(:post).permit(:user_id,:title,:body,:capacity,:is_free,:is_stop,:status)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless  @user == current_user
       flash[:post_notice] =  'ユーザーが正しくありません。'
      redirect_to posts_path
    end
  end
  
  def ensure_guest_user
    if  current_user.name == "guestuser"
      flash[:post_notice] =  'ゲストユーザーは遷移できません。'
      redirect_to posts_path
    end
  end

end
