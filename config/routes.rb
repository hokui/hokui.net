Rails.application.routes.draw do
  namespace :api do
    resource  :session,     only: [               :create,          :destroy]

    resources :users,       only: [:index, :show, :create,          :destroy] do
      collection do
        get  :profile
        post :activate
      end
      member do
        post :approve
      end
    end

    resources :class_years, only: [:index, :show, :create, :update, :destroy]
  end

  match "*path" => "application#index", via: [:get, :post]
  root :to => "application#index", via: [:get, :post]
end
