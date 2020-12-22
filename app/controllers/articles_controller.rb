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
      redirect_to @article
    else
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
      render 'edit'
    end
  end

  def destroy
    @article=Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def require_same_user
    @article=Article.find(params[:id])
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end
