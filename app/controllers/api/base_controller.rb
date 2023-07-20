module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    protected

    def current_user!
      token = request.headers['Authorization'].split(' ').last
      payload = JWT.decode(token, 'SECRET').first
      @current_user ||= User.find(payload['sub'])
    rescue StandardError
      render json: { error: 'Invalid access token', status: :unauthorized }, status: :unauthorized
    end
  end
end
