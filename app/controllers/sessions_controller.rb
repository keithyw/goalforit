class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      respond_to do |format|      
        format.html { redirect_back_or user }
        format.json { head :no_content, status: :ok }
      end
    else
      flash.now[:danger] = 'Invalid login'
      respond_to do |format|
        format.html { render 'new'}
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
