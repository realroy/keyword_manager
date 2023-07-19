# frozen_string_literal: true

class UserKeyword < ApplicationRecord
  belongs_to :user, inverse_of: :user_keywords
  belongs_to :keyword, inverse_of: :user_keywords
end
