class KeywordUploadFile
  include ActiveModel::Model

  attr_accessor :file

  validates :file, presence: true
  validate :keywords_number_in_file

  def initialize(file: nil)
    @file = file
  end

  def encoded_file
    @encoded_file ||= file.read.force_encoding('UTF-8')
  rescue StandardError
    errors.add(:file, 'File cannot be encoded to UTF-8')
  end

  def words
    @words ||= encoded_file.split(',').map(&:strip)
  rescue StandardError
    errors.add(:file, 'File cannot be split to words')
  end

  private

  def keywords_number_in_file
    maximum_keywords_per_upload = ENV.fetch('MAXIMUM_KEYWORDS_PER_UPLOAD', 100).to_i
    minimum_keywords_per_upload = ENV.fetch('MINIMUM_KEYWORDS_PER_UPLOAD', 1).to_i

    if words.size > maximum_keywords_per_upload
      errors.add(:file, "You can upload maximum #{maximum_keywords_per_upload} keywords per file")
    elsif words.size < minimum_keywords_per_upload
      errors.add(:file, "You can upload minimum #{minimum_keywords_per_upload} keywords per file")
    end
  end
end
