# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'PUT #update' do
    context 'when pass valid data' do
      it 'return 204 status code' do
        user = create(:user)
        user_params = { name: 'Usuario teste', email: 'usuario@teste.com', password: '123123123' }

        put "/api/v1/users/#{user.id}", params: { user: user_params }, headers: get_headers(user)

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
