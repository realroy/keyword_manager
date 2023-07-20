class ExtractKeywordsFromFileService
  def initialize(file:, user:)
    @file = file
    @user = user
  end

  def call
    new_words = extract_words_form_upload_file
    @user.user_keywords.destroy_all
    @user.keywords.destroy_all

    create_new_keywords(new_words)
  end

  private

  def extract_words_form_upload_file
    raw_file = @file.read.force_encoding('UTF-8')
    raw_file.split("\n").map(&:strip)
  end

  def create_new_keywords(new_words)
    keywords = []
    ActiveRecord::Base.transaction do
      new_words.each do |new_word|
        keywords << @user.keywords.create!(word: new_word)
      end
    end

    keywords
  end
end
