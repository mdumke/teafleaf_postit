class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/:id
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    @post.creator = current_user

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
    if @post.update(post_params)
      flash['notice'] = 'Your post was updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by_id(params[:id])
  end
end
