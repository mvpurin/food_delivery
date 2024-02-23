class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'New category was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def edit

  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, status: 303
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
