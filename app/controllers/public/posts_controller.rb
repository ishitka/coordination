class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      redirect_to root_path
    else
      new_post_path
    end
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path
  end
  
private

  def post_params
    params.require(:post).permit(:title, :introduction, :sex, :user_id, :image)
  end
  
end
