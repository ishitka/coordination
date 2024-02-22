class Public::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    if User.update(user_params)
      redirect_to admin_user_path(current_user)
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    current_user.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @post = Post.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :telephone_number, :email, :password, :password_confirmation, :account, :is_active, :height, :introduction, :image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end