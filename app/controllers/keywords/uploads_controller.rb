# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    before_action :authenticate_user!

    def show
      @keyword_upload_file = KeywordUploadFile.new
    end

    def update
      @keyword_upload_file = KeywordUploadFile.new(file: uploads_params[:file])
      if keyword_upload_file.valid?
        keywords = ExtractKeywordsFromFileService.new(words: @keyword_upload_file.words, user: current_user).call
        ScrapeKeywordsJob.perform_async(keywords.map(&:id))

        redirect_to keywords_path, notice: 'Keywords is starting to scrape'
      else
        flash[:alert] = 'Something went wrong! Please try again.'
        render 'show'
      end
    end

    private

    def uploads_params
      params.require(:keyword_upload_file).permit(:file)
    end
  end
end
