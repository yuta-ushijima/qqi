class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.published.includes(:user)
    render json: articles
  end

  def create
    @article = current_user.articles.create!(article_params)
    render json: @article
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :user_id)
    end
end
