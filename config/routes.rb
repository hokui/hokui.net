Rails.application.routes.draw do
  namespace :api do
    resource  :session,        only: [               :create,          :destroy]

    resource  :password_reset, only: [               :create, :update          ]

    resources :users,          only: [:index, :show, :create,          :destroy] do
      collection do
        get  :profile
        post :activate
      end
      member do
        post :approve
      end
    end

    resources :class_years,    only: [:index, :show, :create, :update, :destroy]

    resources :subjects,       only: [:index, :show, :create, :update, :destroy]

    resources :semesters,      only: [:index, :show, :create, :update, :destroy]

    match "*path" => "application#not_found", via: :all
  end

  if Rails.env.development?
    get "*path" => "application#index"
    root :to => "application#index"
  end
end
