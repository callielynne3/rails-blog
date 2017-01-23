class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "callie", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show 
    @article = Article.find(params[:id])
  end 

  def new 
    @article = Article.new
    # The reason why we added @article = Article.new in the ArticlesController is that otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.
  end 

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # render plain: params[:article].inspect

    @article = Article.new(article_params)
  
    if @article.save
      redirect_to @article
    else
      render new_article_path
      # use render instead of redirect_to
      # why does this redirect me to /articles?????
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end

# rails routes order:
# index, show, new, edit, create, update and destroy