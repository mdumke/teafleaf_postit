class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.build(comment_params)

    @comment.creator = current_user

    if @comment.save
      flash['notice'] = 'Your comment was added'
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find_by_id(params[:id])
    Vote.create(voteable: comment, creator: current_user, vote: params[:vote])

    flash['notice'] = 'Your vote was counted'
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
