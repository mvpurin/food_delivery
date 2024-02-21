class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show

  end

  private

  def load_category
    @category = Category.find(params[:id])
  end
end
