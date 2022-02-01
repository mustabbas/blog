class CommentsController < ApplicationController
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
      format.html do
        if comment.save
          Comment.update_comments_counter(params[:id])
          flash[:success] = 'Comment saved successfully'
          redirect_to all_posts_path(params[:user_id])
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: comment }
        end
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
