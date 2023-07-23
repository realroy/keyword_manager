# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    before_action :authenticate_user!

    def show; end

    def update
      keywords = ExtractKeywordsFromFileService.new(file: uploads_params[:file], user: current_user).call
      ScrapeKeywordsJob.perform_async(keywords.map(&:id))

      redirect_to keywords_path, notice: 'Your keywords are starting to scrape, Please wait a few minutes.'
    rescue StandardError => e
      logger.error e

      render 'show', error: 'Something went wrong! Please try again.'
    end

    private

    def uploads_params
      params.require(:uploads).permit(:file)
    end
  end
end
