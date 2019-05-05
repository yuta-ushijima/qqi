Rails.application.routes.draw do

  root 'homes#index'

  get '/sign_in',  to: 'homes#index'
  get '/articles', to: 'homes#index'

  namespace :api do
    namespace :v1 do
      resources :articles
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations"
      }
    end
  end
end
