class Admin::SearchesController < ApplicationController
  
  def search
    @range = params[:range]

    if @range == "Tag"
      @tags = Tag.looks(params[:search], params[:word])
      @tags.each do |tag|
        @posts = tag.posts.where(status: 0).page(params[:page])
      end
      render "admin/searches/search_result"
    else
      @posts = Post.looks(params[:search], params[:word]).page(params[:page])
      render "admin/searches/search_result"
    end
  end
  
end
