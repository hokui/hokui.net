Rails.application.routes.draw do
  namespace :api do
    resource  :session, only: [:create, :destroy]

    resources :users,   only: [:index, :show, :create] do
      collection do
        get  :profile
        post :activate
      end
      member do
        get  :approve
      end
    end
  end

  match "*path" => "application#index", via: [:get, :post]
  root :to => "application#index", via: [:get, :post]
end
