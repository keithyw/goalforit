class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :new, :edit, :create, :update]
  
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.xml { render xml: @categories }
      format.json { render json: @categories }
    end
  end
  
  def goals
    @category = Category.find(params[:id])
    respond_to do |format|
      format.json { render :json => @category.goals.to_json(
        :include => {
          :user => {
            :except => [:email, :password_digest, :created_at, :updated_at],
            :include => {
              :profile => {
                :except => [:birthday, :created_at, :updated_at]
              }
            } 
          },
          :category => {
            :except => [:created_at, :updated_at]
          }
        }
      )}
    end
  end
  
  def goal_categories
    @categories = Category.all
    respond_to do |format|
      format.json { render :json => @categories.to_json(
        :methods => :goal_count
      )}
    end
  end
  
  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @category }
      format.json { render json: @category }
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
  
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
