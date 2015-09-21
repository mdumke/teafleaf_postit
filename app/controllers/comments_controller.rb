class CommentsController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.build(comment_params)

    # !!! Hardcode this for now
    @comment.creator = User.first

    if @comment.save
      flash['notice'] = 'Your comment was added'
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
