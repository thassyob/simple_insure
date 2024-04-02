# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Sessions', type: :request do
  describe 'POST #create' do
    context 'when user sign in' do
      it 'return 200 status code' do
        user = create(:user, password: '123123123')
        user_params = { email: user.email, password: user.password,
                        password_confirmation: user.password }

        post '/api/v1/auth/sign_in', params: user_params

        expect(response).to have_http_status(:ok)
      end

      it 'return registration created and his attributes' do
        user = create(:user)
        user_params = { email: user.email, password: user.password,
                        password_confirmation: user.password }

        post '/api/v1/auth/sign_in', params: user_params

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
        expect(json_body).to have_key(:email)
      end
    end

    context 'when user pass invalid data' do
      it 'must return 401 status code' do
        user_params = { email: 'invalid email', password: 'invalid password' }

        post '/api/v1/auth/sign_in', params: user_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'when the session storage is clean' do
      user = create(:user)

      delete '/api/v1/auth/sign_out', headers: get_headers(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
