class Public::RelationshipsController < ApplicationController
  # フォローする
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    # redirect_to request.referer
  end
  #フォロー解除
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    # redirect_to request.referer
  end
  
  def following
      user = User.find(params[:user_id])
      @users = user.following
  end
  
  def followers
      user = User.find(params[:user_id])
      @users = user.followers
  end
end
