class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.published.includes(:user)
    render json: articles
  end
end
