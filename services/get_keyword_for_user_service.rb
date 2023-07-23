# frozen_string_literal: true

class GetKeywordForUserService
  def initialize(user:, keyword_id:)
    @user = user
    @keyword_id = keyword_id
  end

  def call
    @user.keywords.find(@keyword_id)
  end
end
