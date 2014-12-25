Rails.application.routes.draw do
  namespace :api do
    resource  :session,            only: [               :create,          :destroy]

    resource  :password_reset,     only: [               :create, :update          ]

    resource  :activation_request, only: [               :create                   ]

    resource  :profile,            only: [        :show,          :update          ] do
      resource :password,          only: [                        :update          ]
    end

    resources :users,              only: [:index, :show, :create,          :destroy] do
      collection do
        post :activate
      end
      member do
        post :approve
      end
    end

    resources :class_years,        only: [:index, :show, :create, :update, :destroy]

    resources :subjects,           only: [:index, :show, :create, :update, :destroy]

    resources :semesters,          only: [:index, :show, :create, :update, :destroy]

    match "*path" => "application#not_found", via: :all
  end
end
