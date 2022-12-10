class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    ensure_correct_user
    @user = User.find(params[:id])
  end

  def update
    ensure_correct_user
    if @user.update(user_params)
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def quit
    ensure_correct_user
    @user = User.find(params[:id])
  end

  def withdraw
    ensure_correct_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction,:email,:profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
