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

    def upload
      keywords = ExtractKeywordsFromFileService.new(file: uploads_params[:file], user: User.first).call
      keywords.each { |keyword| ScrapeFromKeywordService.new(keyword:).call }

      render json: keywords
    rescue StandardError => e
      p 'Error', e
      render json: { error: 'Something went wrong! Please try again.' }, status: :internal_server_error
    end

    private

    def uploads_params
      params.require(:uploads).permit(:file)
    end
  end
end
