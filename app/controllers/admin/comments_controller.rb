class Admin::CommentsController < ApplicationController

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

end
