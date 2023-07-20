# frozen_string_literal: true

module Api
  class KeywordsController < ApplicationController
    def index
      keywords = GetKeywordsForUserService.new(user: User.first, q: params[:q]).call

      render json: keywords
    end

    def show
      keyword = GetKeywordForUserService.new(user: User.first, keyword_id: params[:id]).call

      render json: keyword
    end
  end
end
