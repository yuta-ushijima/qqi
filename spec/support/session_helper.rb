module SessionHelpers

  def sign_in(session_params)
    post(api_v1_user_session_path, params: session_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' })
    JSON.parse(response.body)["data"]
  end
end
