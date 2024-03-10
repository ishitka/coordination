class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite_action { |favorite, post| favorite.save and redirect_to redirect_path(favorite, post) }
  end

  def destroy
    favorite_action { |favorite, post| favorite.destroy and redirect_to redirect_path(favorite, post) }
  end

  private

  def favorite_action
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_or_initialize_by(post_id: post.id)
    yield favorite, post
  end

  def redirect_path(favorite, post)
    if request.referrer == root_url
      root_path
    elsif request.referrer.include?('/users')
      request.referrer
    else
      post_path(post)
    end
  end
end