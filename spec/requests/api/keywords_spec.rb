# frozen_string_literal: true

require 'rails_helper'
require 'jwt'

RSpec.describe 'Api::Keywords', type: :request do
  let(:user) { create(:user) }
  let(:keywords) { create_list(:keyword, 3) }

  let(:access_token) do
    JWT.encode({ sub: user.id }, 'SECRET')
  end

  describe 'GET /index' do
    context 'when user doesn\'t loged in' do
      it 'returns http unauthorized' do
        get api_keywords_path

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user loged in' do
      before do
        keywords.each { |keyword| create(:user_keyword, keyword:, user:) }

        get api_keywords_path,
            headers: { 'Authorization': "Bearer #{access_token}" }
      end

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'return keywords' do
        expect(response.body).to eq(keywords.to_json)
      end
    end
  end

  describe 'GET /show' do
    context 'when user doesn\'t logged in' do
      it 'returns http unauthorized' do
        get api_keyword_path(keywords.first.id)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when keyword is not found' do
      it 'returns http not found' do
        get api_keyword_path(-1),
            headers: { 'Authorization': "Bearer #{access_token}" }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when keyword is found' do
      before do
        keywords.each { |keyword| create(:user_keyword, keyword:, user:) }
      end
      it 'returns http ok' do
        get api_keyword_path(keywords.first.id),
            headers: { 'Authorization': "Bearer #{access_token}" }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
