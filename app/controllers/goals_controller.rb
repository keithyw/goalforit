class GoalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :logged_in_user, only: [:new, :create, :user, :edit, :update]
  
  def created_at
    created_at = attributes["created_at"]
    created_at ? created_at.to_f : null
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end

  def new
    @goal = current_user.goals.build
  end
  
  def index
    @goals = Goal.all
    respond_to do |format|
      format.html
      format.xml { render :xml => @goals.to_xml(
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
      format.json { render :json => @goals.to_json(
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
  
  def user
    @goals = current_user.goals.all
    respond_to do |format|
      format.html
      format.xml { render :xml => @goals.to_xml(
        :include => {          
          :category => {
            :except => [:created_at, :updated_at]
          }
        }
      )}
      format.json { render :json => @goals.to_json(
        :include => {          
          :category => {
            :except => [:created_at, :updated_at]
          }
        }
      )}
    end
  end
  
  def edit
    @goal = current_user.goals.find(params[:id])
  end
  
  def update
    @goal = current_user.goals.find(params[:id])
    logger.debug("found goal")
    if @goal.update(goal_params)
      logger.debug("update ok")
      respond_to do |format|
        format.html { redirect_to @goal }
        format.xml { render xml: @goal, status: :ok, location: @goal }
        format.json { render json: @goal, status: :ok, location: @goal }
      end
    else
      logger.debug("update not ok")
      respond_to do |format|
        format.html { render 'edit' }
        format.xml { render xml: @goal.errors, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @goal = Goal.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @goal.to_xml(
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
      format.json { render :json => @goal.to_json(
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
  
  def create
    @goal = current_user.goals.build(goal_params)
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