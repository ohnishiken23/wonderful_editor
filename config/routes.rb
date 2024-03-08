Rails.application.routes.draw do
  get "users/index"
  get "users/show"
  get "users/new"
  get "users/create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :users, defaults: { format: :json }
      resources :articles, defaults: { format: :json }, only: [:index]
    end
  end
end
