# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        skip_before_action :authenticate_api_v1_user!

        def render_create_success
          render json: { user: Api::V1::Auth::Registrations::UserSerializer.new(@resource, sign_up_params) }
        end

        private

        def sign_up_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
