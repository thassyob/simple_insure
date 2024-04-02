# frozen_string_literal: true

module Api
  module V1
    module Auth
      module Sessions
        class UserSerializer < ActiveModel::Serializer
          attributes :id, :name, :email
        end
      end
    end
  end
end
