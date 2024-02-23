class Admin::ItemsController < Admin::BaseController
  before_action :load_category, only: [:new, :create]
  before_action :load_item, only: [:edit, :update, :destroy]

  def new
    @item = @category.items.new
  end

  def create
    @item = @category.items.new(item_params)

    if @item.save
      redirect_to admin_categories_path, notice: 'New item was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to admin_category_path(@item.category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_category_path(@item.category)
  end

  private

  def load_category
    @category = Category.find(params[:category_id])
  end

  def load_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :amount, :additional_info)
  end
end
