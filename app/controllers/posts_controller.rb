class PostsController < ApplicationController
  load_and_authorize_resource :posts

  def index
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = Comment.where(user_id: params[:user_id], post_id: params[:post_id])
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.create(params.require(:post).permit(:title, :text))
    post.user_id = params[:user_id]
    post.comments_counter = 0
    post.likes_counter = 0
    respond_to do |format|
      format.html do
        if post.save
          Post.update_posts_counter(params[:user_id])
          flash[:success] = 'post saved successfully'
          redirect_to all_posts_path(params[:user_id])
        else
          flash.now[:error] = 'Error: post could not be saved'
          render :new, locals: { post: @post }
        end
      end
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to all_posts_path(params[:user_id])
    flash[:alert] = 'Your post was successfully deleted!'
  end
end
