class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @posts = Post.all
    if params[:range] == "Tag"
      @tag_posts = @posts.looks(params[:search], params[:word], params[:range]).page(params[:page])
    else 
      @posts = @posts.includes(:tags).looks(params[:search], params[:word], params[:range]).page(params[:page])
    end
    render "admin/searches/search_result"
  end
  
end