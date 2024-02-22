class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
   @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@post.user.id)
  end
  
private

  def post_params
    params.require(:post).permit(:title, :introduction, :sex, :user_id, :image)
  end
end
