# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    before_action :authenticate_user!

    def show; end

    def update
      keywords = ExtractKeywordsFromFileService.new(file: uploads_params[:file], user: current_user).call
      keywords.each { |keyword| ScrapeFromKeywordService.new(keyword:).call }

      redirect_to keywords_path
    rescue StandardError => e
      p 'Error', e

      flash[:error] = 'Something went wrong! Please try again.'
      render 'show'
    end

    private

    def uploads_params
      params.require(:uploads).permit(:file)
    end
  end
end
