class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    articles = Article.published.includes(:user).order(created_at: :desc)
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

  def update
    @article.update!(article_params)
    render json: @article
  end

  def destroy
    @article.destroy!
    render json: {}, status: 204
  end

  private

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :post_status)
    end
end
