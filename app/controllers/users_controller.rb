class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @user=User.new
  end

  def create
    @user=User.new(params.require(:user).permit(:username, :email, :password))

    if @user.save
      session[:user_id] = @user.id
      flash[:notice]= "You have successfully signed up"
      redirect_to @user
    else
      render :new
    end
  end

  def index
    @user=User.all
  end

  def show
    @user = User.find(params[:id])
    @article=@user.articles
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "User was updated successfully."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
   @user=User.find(params[:id])
   @user.destroy
   session[:user_id] = nil
   flash[:notice] = "Account and all associated articles successfully deleted"
   redirect_to articles_path
  end
  private
  def require_same_user
    @user=User.find(params[:id])
    if current_user != @user
      #render html: helpers.tag.strong('You can edit or delete only your Account ')

      redirect_to @user
    end
  end
end
