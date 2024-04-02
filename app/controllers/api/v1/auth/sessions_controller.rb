# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        skip_before_action :authenticate_api_v1_user!

        def render_create_success
          render json: @resource,
                 serializer: Api::V1::Auth::Sessions::UserSerializer,
                 status: :ok
        end

        def render_destroy_success
          head :no_content
        end
      end
    end
  end
end
