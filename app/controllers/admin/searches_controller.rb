class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word], params[:sex])
    end
  end
end
