class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, only: [:show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'New category was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
