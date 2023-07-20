# frozen_string_literal: true

module Api
  class KeywordsController < BaseController
    def index
      keywords = GetKeywordsForUserService.new(user: current_user!, q: params[:q]).call

      render json: keywords
    end

    def show
      keyword = GetKeywordForUserService.new(user: current_user!, keyword_id: params[:id]).call

      render json: keyword
    end

    def upload
      keywords = ExtractKeywordsFromFileService.new(file: uploads_params[:file], user: current_user!).call
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
