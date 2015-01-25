class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :edit, :update]
  skip_before_filter :verify_authenticity_token
  
  def new
    @profile = current_user.build_profile
  end
  
  def create
    @profile = current_user.build_profile(profile_params)   
    if @profile.save
      respond_to do |format|
        format.html { redirect_to @profile }
        format.json { render json: @profile, status: :created, location: @profile }
        format.xml { render xml: @profile, status: :created, location: @profile }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.xml { render xml: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @profile = current_user.profile
    respond_to do |format|
      format.html
      format.json { render json: @profile }
      format.xml { render xml: @profile }
    end
  end
  
  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      respond_to do |format|
        format.html { redirect_to @profile }
        format.json { render json: @profile, status: :ok, location: @profile }       
        format.xml { render xml: @profile, status: :ok, location: @profile }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.xml { render xml: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:username, :first_name, :last_name, :birthday)
    end
end