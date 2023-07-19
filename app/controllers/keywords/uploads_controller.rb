# frozen_string_literal: true

module Keywords
  class UploadsController < ApplicationController
    def show; end

    def update
      raw_file = uploads_params[:file].read
      words = raw_file.split("\n").map(&:strip)
      new_words = words - Keyword.pluck(:word)

      ActiveRecord::Base.transaction do
        new_words.each { |new_word| current_user.keywords.create! word: new_word }
      end

      redirect_to keywords_path
    rescue StandardError => e
      p e
      flash[:error] = 'Something went wrong! Please try again.'
      render 'show'
    end

    def uploads_params
      params.require(:uploads).permit(:file)
    end
  end
end
