# frozen_string_literal: true

class Keyword < ApplicationRecord
  has_many :user_keywords, inverse_of: :keyword, dependent: :nullify
  has_many :user, through: :user_keywords
end
