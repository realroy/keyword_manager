# frozen_string_literal: true

module Api
  class UsersController < BaseController
    def sign_in
      user = User.find_for_authentication(email: sign_in_params[:email])
      if user&.valid_password?(sign_in_params[:password])
        payload = { sub: user.id, exp: 4.hours.from_now.to_i }
        jwt = JWT.encode(payload, ENV.fetch('JWT_SECRET'))

        render json: { access_token: jwt }
      else
        render json: { error: 'Invalid email or password', status: :unauthorized }, status: :unauthorized
      end
    end

    private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end
  end
end
