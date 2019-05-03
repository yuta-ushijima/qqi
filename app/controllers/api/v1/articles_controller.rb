class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    articles = Article.published.includes(:user)
    render json: articles
  end

  def create
    @article = current_user.articles.create!(article_params)
    render json: @article
  end

  def show
    @article = current_user ? current_user.articles.find(params[:id])
                            : Article.published.find(params[:id])
    render json: @article
  end

  private

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :user_id)
    end
end
