# frozen_string_literal: true

class Keyword < ApplicationRecord
  enum scrape_status: { pending: 'PENDING', sucess: 'SUCCESS', failed: 'FAILED' }, _default: 'PENDING'

  has_many :user_keywords, inverse_of: :keyword, dependent: :nullify
  has_many :user, through: :user_keywords

  validates :word, presence: true, uniqueness: true
end
