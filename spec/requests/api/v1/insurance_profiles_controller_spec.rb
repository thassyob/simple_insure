# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::InsuranceProfilesController', type: :request do
  describe 'POST #create' do
    context 'when success' do
      context 'when creating an insurance profile' do
        it 'returns a 201 status code and attributes' do
          user = create(:user)
          insurance_profile_params = attributes_for(:insurance_profile)

          expected_response_body = {
            id: 1,
            age: 35,
            dependents: 2,
            income: 0,
            marital_status: 'married',
            risk_questions: true,
            house: { ownership_status: 'owned' },
            vehicle: { year: '2018' }
          }

          post '/api/v1/insurance_profiles',
               params: { insurance_profile: insurance_profile_params }, headers: get_headers(user)

          expect(response).to have_http_status(:created)
          expect(json_body).to eq(expected_response_body)
        end
      end
    end

    context 'when errors' do
      context 'when unauthorized' do
        it 'returns a 401 status code and error message' do
          user = create(:user)
          insurance_profile_params = attributes_for(:insurance_profile)

          post '/api/v1/insurance_profiles',
               params: { insurance_profile: {} }

          expect(response).to have_http_status(:unauthorized)
          expect(json_body).to eq({ errors: ['You need to sign in or sign up before continuing.'] })
        end
      end

      context 'when pass invalid params' do
        it 'must return 422 status code and error message' do
          user = create(:user)
          insurance_profile_params = attributes_for(:insurance_profile, age: nil)

          post '/api/v1/insurance_profiles',
               params: { insurance_profile: insurance_profile_params }, headers: get_headers(user)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to eq({ errors: { age: ["can't be blank"] } })
        end
      end
    end
  end
end
