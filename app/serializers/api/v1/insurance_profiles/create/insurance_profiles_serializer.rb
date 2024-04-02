# frozen_string_literal: true

module Api
  module V1
    module InsuranceProfiles
      module Create
        class InsuranceProfilesSerializer < ActiveModel::Serializer
          attributes :id, :age, :dependents, :income, :marital_status, :risk_questions, :house, :vehicle
        end
      end
    end
  end
end
