class Admin::SearchesController < ApplicationController
  
  def search
    @range = params[:range]

    if @range == "Tag"
      @tags = Tag.looks(params[:search], params[:word])
      render "admin/searches/search_result"
    else
      @posts = Post.looks(params[:search], params[:word])
      render "admin/searches/search_result"
    end
  end
  
end
