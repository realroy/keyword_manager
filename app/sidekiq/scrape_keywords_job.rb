# frozen_string_literal: true

class ScrapeKeywordsJob
  include Sidekiq::Job

  def perform(keyword_ids)
    keywords = Keyword.find(keyword_ids)
    keywords.each { |keyword| ScrapeFromKeywordService.new(keyword:).call }
  end
end
