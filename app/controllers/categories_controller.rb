class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:new, :create]

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash['notice'] = 'Category has been created'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def set_category
    @category = Category.find_by_slug(params[:id])

    unless @category
      flash['error'] = 'Could not find this category'
      redirect_to root_route
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
