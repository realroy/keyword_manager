# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    def show; end

    def update
      new_words = extract_words_form_upload_file - Keyword.pluck(:word)
      create_new_keywords(new_words)
    rescue StandardError => e
      p e
      flash[:error] = 'Something went wrong! Please try again.'
      render 'show'
    end

    private

    def uploads_params
      params.require(:uploads).permit(:file)
    end

    def extract_words_form_upload_file
      raw_file = uploads_params[:file].read

      raw_file.split("\n").map(&:strip)
    end

    def create_new_keywords(new_words)
      ActiveRecord::Base.transaction do
        new_words.each { |new_word| current_user.keywords.create! word: new_word }
      end
    end
  end
end
