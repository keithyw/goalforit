class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.xml { render xml: @users }
      format.json { render json: @users }
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @user }
      format.json { render json: @user }
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
