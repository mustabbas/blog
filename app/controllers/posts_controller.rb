class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = Post.where(author_id: params[:id])
  end

  def show
    @post = Post.find(params[:post_id])
    @commit = Commit.where(author_id: params[:user_id], post_id: params[:post_id])
  end
end
