# frozen_string_literal: true

class ExtractKeywordsFromFileService
  def initialize(file:, user:)
    @file = file
    @user = user
  end

  def call
    words = extract_words_form_upload_file

    old_keywords = Keyword.where(word: words)

    ActiveRecord::Base.transaction do
      @user.user_keywords.destroy_all
      attach_old_keywords_to_user(old_keywords)
      create_new_keywords(old_keywords, words)
    end

    @user.keywords
  end

  private

  def extract_words_form_upload_file
    raw_file = @file.read.force_encoding('UTF-8')
    raw_file.split("\n").map(&:strip)
  end

  def attach_old_keywords_to_user(old_keywords)
    old_keywords.update(scrape_status: Keyword.scrape_statuses[:pending])
    @user.user_keywords.create!(old_keywords.map { |keyword| { keyword: } })
  end

  def create_new_keywords(old_keywords, words)
    new_words = words - old_keywords.map(&:word)
    @user.keywords.create!(new_words.map { |word| { word: } })
  end
end
