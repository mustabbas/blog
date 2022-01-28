class LikesController < ApplicationController
  def create
    like = Like.new(user_id: params[:user_id], post_id: params[:id])
    if like.save
      Like.update_likes_counter(params[:id])
      flash[:success] = 'Like add successfully'
    else
      flash.now[:error] = 'Error: Like not be added'
    end
    redirect_to all_posts_path(params[:user_id])
  end
end
