class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      
      redirect_to user, notice: "logged in successfully"
    else
      flash.now[:alert] = "Please check your email and password"
      render 'new'
    end
  end

  def destroy
   session[:user_id] = nil
   flash[:notice] = "Logged out"
   redirect_to root_path
 end
end
