class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy
 
  def index
    @comments = Comment.all
  end

  def show
    set_comment
  end

  def new
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:commenter, :body, :article_id)
    end
end
