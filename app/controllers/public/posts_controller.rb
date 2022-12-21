class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts =Post.where(status: 0)
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
    @participants = @post.participants.where(approval_status: 0)
    #参加中
    @join = @post.participants.where(approval_status: 1)
    # 参加しているかどうか
    @member = Participant.find_by(user_id: current_user.id,post_id: @post.id)
    # 参加中の人がキャパと同じかそれ以上の時、募集をストップ
    if @join.count >= @post.capacity
       @post.is_stop = true
       @post.save
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
    @user = current_user
    @tag = Tag.find_by(name: params[:name])
    # tagを削除すると検索時エラーがかかるのでかわりのif文
    if @tag
       @posts = @tag.posts
    else
    end
  end

  private
  def post_params
      params.require(:post).permit(:user_id,:title,:body,:capacity,:is_free,:is_stop,:status)
  end

end
