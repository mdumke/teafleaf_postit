class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/:id
  def show
    @post = Post.find_by_id(params[:id])
    redirect_to 'index' unless @post

    @comments = @post.comments
  end

  # GET /posts/new
  def new
  end

  # POST /posts
  def create
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH /posts/:id
  def update
  end
end
