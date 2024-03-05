class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = Post.page(params[:page])
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :telephone_number, :email, :password, :password_confirmation, :account, :is_active, :height, :introduction, :image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
