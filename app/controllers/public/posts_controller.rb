class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def index
    @posts =Post.all
  end
  
  def create
    post =current_user.posts.new(post_params)
    if post.save
      redirect_to post_path(post)
    else
      render :new
    end
  end
  
  def show
    @post =Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
       redirect_to post_path(post)
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
      params.require(:post).permit(:user_id,:title,:body,:capacity,:is_free,:is_stop)
  end
  
end
