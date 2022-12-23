class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "Tag"
      @tags = Tag.looks(params[:search], params[:word])
      render "public/searches/search_result"
    else
      @posts_all = Post.looks(params[:search], params[:word])
      # 下書きは排除
      @posts = @posts_all.where(status: 0)
      render "public/searches/search_result"
    end
  end

end
