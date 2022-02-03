class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @comments = Comment.where(post_id: params[:post_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  def new
    @post = Post.find(params[:id])
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: comment } }
    end
  end

  def create
    comment = Comment.new(params.require(:comment).permit(:text))
    post = Post.find(params[:id])
    comment.user_id = params[:user_id]
    comment.post = post
    respond_to do |format|
        if comment.save
          Comment.update_comments_counter(params[:id])
          format.json { render json: { message: 'You have successfully created a comment' } }
          format.html do
          flash[:success] = 'Comment saved successfully'
          redirect_to all_posts_path(params[:user_id])
          end
        else
          
          format.json { render json: { message: "You have An Error #{:error}" } }
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: comment }
      end
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    puts params[:post_id]
    puts params[:id]
    Comment.update_comments_counter(params[:post_id])
    redirect_to all_posts_path(params[:user_id])
    flash[:alert] = 'Your comment was successfully deleted!'
  end
end
