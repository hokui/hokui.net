Rails.application.routes.draw do
  namespace :api do
    resource  :session, only: [:create, :destroy]
    resources :users,   only: [:index, :show, :create]
  end

  get "/users/activate/:email_local/:activation_token" => "users#activate", as: :user_activation

  match "*path" => "application#index", via: [:get, :post]
  root :to => "application#index", via: [:get, :post]
end
