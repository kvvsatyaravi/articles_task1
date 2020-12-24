class ArticlesController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    
    @article = Article.new
  end

  def create
    @article=Article.new(params.require(:article).permit(:title, :description))
    @article.user=current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      flash[:error]= "There is a problem in article creation."
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      flash[:alert]="There is problem in updation of article."
      render 'edit'
    end
  end

  def destroy
    @article=Article.find(params[:id])
    @article.destroy
    flash[:notice] ="Article was deleted successfully."
    redirect_to articles_path
  end

  private
  def require_same_user
    @article=Article.find(params[:id])
    if current_user != @article.user
      flash[:error] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end
