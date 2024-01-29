class ItemsController < ApplicationController
  before_action :load_category, only: [:new, :create]

  def new
    @item = @category.items.new
  end

  def create
    @item = @category.items.new(item_params)

    if @item.save
      redirect_to categories_path, notice: 'New item was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_category
    @category = Category.find(params[:category_id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :amount, :additional_info)
  end
end
