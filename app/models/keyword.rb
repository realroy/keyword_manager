# frozen_string_literal: true

class Keyword < ApplicationRecord
  SCRAPE_STATUSES = { pending: 'pending', success: 'success', failed: 'failed' }.freeze

  enum scrape_status: SCRAPE_STATUSES, default: SCRAPE_STATUSES[:pending]

  has_many :user_keywords, inverse_of: :keyword, dependent: :nullify
  has_many :user, through: :user_keywords
end
