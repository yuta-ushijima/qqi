module SessionHelpers

  # ログインに必要なヘッダー情報の取得
  def authentication_headers_for(user)
    user.create_new_auth_token
  end

end
