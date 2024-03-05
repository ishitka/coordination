class Public::RelationshipsController < ApplicationController
  def create
    if user_signed_in?
      current_user.follow(params[:user_id])
      redirect_to request.referer
    else
      redirect_to new_user_session_path
    end
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
