class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @commit = Commit.where(author_id: params[:user_id], post_id: params[:id])
  end
end
