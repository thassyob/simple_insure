# frozen_string_literal: true

module RequestSpecHelper
  def json_body
    @json_body ||= JSON.parse(response.body, symbolize_names: true)
  end

  def get_headers(user)
    post '/api/v1/auth/sign_in', params: { email: user.email, password: user.password }

    {
      'access-token': response.headers['access-token'],
      'token-type': response.headers['token-type'],
      'client': response.headers['client'],
      'expiry': response.headers['expiry'],
      'uid': response.headers['uid']
    }
  end
end
