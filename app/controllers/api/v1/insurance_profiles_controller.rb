# frozen_string_literal: true

module Api
  module V1
    class InsuranceProfilesController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        insurance_profile = current_api_v1_user.create_insurance_profile!(create_params)

        render json: insurance_profile,
               serializer: Api::V1::InsuranceProfiles::Create::InsuranceProfilesSerializer,
               status: :created
      end

      def calculate_risk_profile
        risk_profile = InsuranceProfileCalculatorService.new(params[:id]).calculate_profile

        render json: risk_profile,
        status: :ok
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
