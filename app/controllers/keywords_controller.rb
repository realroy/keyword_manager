# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = params[:q]
    @keywords = GetKeywordsForUserService.new(user: current_user, q: @q).call
  end

  def show
    @keyword = GetKeywordForUserService.new(user: current_user, keyword_id: params[:id]).call
  end
end
