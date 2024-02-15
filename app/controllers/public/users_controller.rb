class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def withdraw
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :telephone_number, :email, :password, :password_confirmation, :account, :is_active, :height, :introduction)
  end
end
