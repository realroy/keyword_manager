class ExtractKeywordsFromFileService
  def initialize(words:, user:)
    @words = words
    @user = user
  end

  def call
    @user.user_keywords.destroy_all
    @user.keywords.destroy_all

    keywords = []
    ActiveRecord::Base.transaction do
      @words.each do |word|
        keywords << @user.keywords.create!(word:)
      end
    end

    keywords
  end
end
