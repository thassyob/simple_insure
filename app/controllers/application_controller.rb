# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandler

  before_action :authenticate_api_v1_user!
end
