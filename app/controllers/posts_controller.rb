class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  before_action :require_same_user_or_admin, only: [:edit]

  # GET /posts
  def index
    @posts = Post.all.sort_by { |p| p.total_votes }.reverse

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.xml { render xml: @posts }
    end
  end

  # GET /posts/:id
  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post }
    end
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

  # POST /posts/:id/vote
  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash['notice'] = 'Your vote was counted'
        else
          flash['error'] = 'You can only vote on a post once'
        end

        redirect_to :back
      end

      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def require_creator_or_admin
    access_denied unless logged_in? && (current_user == @post.creator) || admin?
  end
end
