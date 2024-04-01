# frozen_string_literal: true

module Api
  module V1
    module Auth
      module Registrations
        class UserSerializer < ActiveModel::Serializer
          attributes :id, :name, :email
        end
      end
    end
  end
end
