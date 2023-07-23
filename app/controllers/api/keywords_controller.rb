# frozen_string_literal: true

module Api
  class KeywordsController < BaseController
    class KeywordUploadFileValidationError < StandardError
      def initialize(keywords_upload_file)
        @keyword_upload_file = keywords_upload_file
        super('KeywordUploadFileValidationError')
      end
    end

    rescue_from KeywordUploadFileValidationError, with: :render_keyword_upload_file_validation_error

    def index
      keywords = GetKeywordsForUserService.new(user: current_user!, q: params[:q]).call

      render json: keywords
    end

    def show
      keyword = GetKeywordForUserService.new(user: current_user!, keyword_id: params[:id]).call

      render json: keyword
    end

    def upload
      @keyword_upload_file = KeywordUploadFile.new(file: uploads_params[:file])

      raise KeywordUploadFileValidationError, @keyword_upload_file unless @keyword_upload_file.valid?

      keywords = ExtractKeywordsFromFileService.new(words: @keyword_upload_file.words, user: current_user!).call

      ScrapeKeywordsJob.perform_async(keywords.map(&:id))

      render json: keywords
    end

    private

    def uploads_params
      params.permit(:file)
    end

    def render_keyword_upload_file_validation_error(err)
      Rails.logger.error err

      render json: { errors: { file: err.keyword_upload_file.full_messages_for(:file) } }, status: :bad_request
    end
  end
end
