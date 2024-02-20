class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:ward])
    else
      @posts = Post.looks(params[:search], params[:ward], params[:sex])
    end
  end
end
