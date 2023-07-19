# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = params[:q]
    @keywords = if @q.present?
                  current_user.keywords.where('word ILIKE ?', "%#{params[:q]}%")
                else
                  current_user.keywords
                end
  end

  def show
    @keyword = current_user.keywords.find(params[:id])
  end
end
