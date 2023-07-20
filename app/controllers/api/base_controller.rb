module Api
  class UnauthorizedError < StandardError; end

  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from UnauthorizedError, with: :render_unauthorized

    protected

    def current_user!
      raise UnauthorizedError, 'Missing authorization header' if request.headers['Authorization'].nil?

      token = request.headers['Authorization'].split(' ').last
      payload = JWT.decode(token, ENV.fetch('JWT_SECRET')).first
      User.find(payload['sub'])
    rescue ActiveRecord::RecordNotFound
      raise UnauthorizedError, 'Invalid authorization token'
    end

    private

    def render_unauthorized(err)
      render json: { error: err.message, statusCode: :unauthorized }, status: :unauthorized
    end

    def render_not_found(err)
      render json: { error: err.message, statusCode: :not_found }, status: :not_found
    end
  end
end
