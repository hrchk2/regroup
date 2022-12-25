class Admin::SearchesController < ApplicationController

  def search
    @tag_posts = Post.all
    @posts = Post.all
    @range = params[:range]

    if params[:range] == "Tag" && params[:word].present?
      @tag_posts = @tag_posts.includes(:tags).looks(params[:search], params[:word], params[:range]).page(params[:tag_page])
      @posts = []
    elsif params[:range] == "Post" && params[:word].present?
      @tag_posts = []
      @posts = @posts.includes(:tags).looks(params[:search], params[:word], params[:range]).page(params[:page])
    else
      @tag_posts = @tag_posts.page(params[:tag_page])
      @posts = @posts.page(params[:page])
    end
    render "admin/searches/search_result"
  end

end
