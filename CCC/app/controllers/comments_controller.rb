class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end
  
  def create
    @post = Post.find(comment_params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id=comment_params[:user_id]
    if @comment.save
      flash[:success] = "Commento inviato"
      redirect_to @post
    else
      redirect_to root_url, status: :unprocessable_entity
    end
  end

  def destroy
    @comment=Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "Commento eliminato"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end

  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

end
