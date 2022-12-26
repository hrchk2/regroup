class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @posts= Post.where(status: 0)

    if @range == "Tag"
      @tag_posts = @posts.looks(params[:search], params[:word], params[:range]).page(params[:page])
    else
      @posts = @posts.looks(params[:search], params[:word], params[:range]).page(params[:page])
    end
      render "public/searches/search_result"
  end

end