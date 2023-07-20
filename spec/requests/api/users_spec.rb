# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::UsersController', type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/users/sign_in' do
    context 'when gived invalid information' do
      it 'returns http unauthorized' do
        post api_users_sign_in_path, params: { user: { email: user.email, password: 'invalid' } }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when gived valid information' do
      it 'returns http ok' do
        post api_users_sign_in_path, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
