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
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    # !!! just hardcoded for now
    @post.creator = User.first

    if @post.save
      flash['notice'] = 'Your post was created.'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH /posts/:id
  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
end
