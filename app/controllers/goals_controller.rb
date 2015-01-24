class GoalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
    @goal = Goal.new
  end
  
  def index
    @goals = Goal.all
    respond_to do |format|
      format.html
      format.xml { render xml: @goals }
      format.json { render json: @goals }
    end
  end

  def show
    @goal = Goal.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @goal }
      format.json { render json: @goal }
    end
  end
  
  def create
    @goal = Goal.new(goal_params)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal }
        format.json { render json: @goal, status: :created, location: @goal }
      else
        format.html { render 'new' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  private
    def goal_params
      params.require(:goal).permit(:goal, :description, :completed, :is_recurring, :finish_time)
    end
end