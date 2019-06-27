# frozen_string_literal: true

class Api::V1::MypageController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    articles = current_user.articles
    render json: articles
  end
end
