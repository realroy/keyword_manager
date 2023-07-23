# frozen_string_literal: true

class Keyword < ApplicationRecord
  SCRAPE_STATUSES = { pending: 'PENDING', sucess: 'SUCCESS', failed: 'FAILED' }.freeze

  enum scrape_status: SCRAPE_STATUSES, default: SCRAPE_STATUSES[:pending]

  has_many :user_keywords, inverse_of: :keyword, dependent: :nullify
  has_many :user, through: :user_keywords

  validate :word, presence: true, uniqueness: true
end
