class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    
  end

  def edit
    @user = current_user
  end

  def update
    if User.update(user_params)
      redirect_to user_path(current_user)
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
  
  private

  def user_params
    params.require(:user).permit(:name, :telephone_number, :email, :password, :password_confirmation, :account, :is_active, :height, :introduction, :image)
  end
end
