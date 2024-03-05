class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    
    if user_signed_in?
      comment = current_user.comments.new(comment_params)
      comment.post_id = post.id
      comment.save
      redirect_to post_path(post)
    else
      redirect_to new_user_session_path
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
