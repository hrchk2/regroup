class Admin::PostsController < ApplicationController

  def index
    @posts =Post.all
  end

  def show
    @post =Post.find(params[:id])
    @comments = @post.comments
    @join = @post.participants.where(approval_status: 1 )
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
end