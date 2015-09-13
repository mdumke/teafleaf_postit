class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
    redirect_to 'index' unless @post

    @comments = @post.comments
  end
end
