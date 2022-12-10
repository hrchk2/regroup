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
  
  private
  def post_params
      params.require(:post).permit(:user_id,:title,:body,:capacity,:is_free,:is_stop)
  end
  
end
