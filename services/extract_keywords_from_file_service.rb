# frozen_string_literal: true

class ExtractKeywordsFromFileService
  def initialize(words:, user:)
    @words = words
    @user = user
  end

  def call
    old_keywords = Keyword.where(word: @words)

    ActiveRecord::Base.transaction do
      attach_old_keywords_to_user(old_keywords)
      create_new_keywords(old_keywords)
    end

    @user.keywords
  end

  private

  def attach_old_keywords_to_user(old_keywords)
    old_keywords.update(scrape_status: Keyword.scrape_statuses[:pending])
    @user.user_keywords.where(keywords: old_keywords).first_or_create!(old_keywords.map { |keyword| { keyword: } })
  end

  def create_new_keywords(old_keywords)
    new_words = @words - old_keywords.map(&:word)
    @user.keywords.create!(new_words.map { |word| { word: } })
  end
end
