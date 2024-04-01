# frozen_string_literal: true

# app/controllers/api/v1/insurance_profiles_controller.rb
module Api
  module V1
    class InsuranceProfilesController < ApplicationController
      def create
        insurance_profile = InsuranceProfile.create!(create_params)

        render json: insurance_profile,
               serializer: Api::V1::InsuranceProfiles::Create::InsuranceProfilesSerializer,
               status: :created
      end

      private

      def create_params
        params.require(:insurance_profile).permit(
          :age, :dependents, :income, :marital_status,
          risk_questions: [], house: [:ownership_status], vehicle: [:year]
        )
      end
    end
  end
end
