Rails.application.routes.draw do

  root 'homes#index'
  namespace :api do
    namespace :v1 do
      resources :articles
    end
  end
end
