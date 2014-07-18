Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create
  end

  get "/users/activate/:email_local/:activation_token" => "users#activate", as: :user_activation
end
