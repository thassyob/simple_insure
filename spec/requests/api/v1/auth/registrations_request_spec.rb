# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Registrations', type: :request do
  describe 'POST #create' do
    context 'when registration ok' do
      it 'return 200 status code' do
        user_params = attributes_for(:user)

        post '/api/v1/auth', params: { user: user_params }

        expect(response).to have_http_status(:ok)
      end

      it 'return registration created and his attributes' do
        user_params = attributes_for(:user)

        post '/api/v1/auth', params: { user: user_params }

        expect(json_body).to have_key(:user)
        expect(json_body[:user]).to have_key(:id)
        expect(json_body[:user]).to have_key(:name)
        expect(json_body[:user]).to have_key(:email)
      end
    end
  end
end
