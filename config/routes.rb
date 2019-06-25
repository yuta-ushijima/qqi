Rails.application.routes.draw do

  root 'homes#index'

  # TODO: 下記のroutingがなかった際フロント側でリロードしてもエラーにならない方法を考える
  get '/sign_in',  to: 'homes#index'
  get '/articles', to: 'homes#index'
  get '/sign_up', to: 'homes#index'
  get '/post_articles', to: 'homes#index'
  get '/complete_user_registration', to: 'homes#index'
  get '/my_page', to: 'homes#index'

  get '/activation', to: 'activations#index'

  namespace :api do
    namespace :v1 do
      get '/my_articles', to: 'mypage#index'
      resources :articles
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations"
      }
    end
  end
end
