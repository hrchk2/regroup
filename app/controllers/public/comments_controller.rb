class Public::CommentsController < ApplicationController
  def create
    @post =Post.find(params[:post_id])
    @comments = @post.comments
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      # flash[:error] = nil
    else
      flash.now[:error] = "コメントを入力してください"
      render :error
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post =Post.find(params[:post_id])
    @comments = @post.comments
    render :create
  end

  private
  def comment_params
      params.require(:comment).permit(:post_id,:body)
  end
end
