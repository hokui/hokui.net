Rails.application.routes.draw do
  namespace :api do
    resource  :session,            only: [               :create,          :destroy]

    resource  :password_reset,     only: [               :create, :update          ]

    resource  :activation_request, only: [               :create                   ]

    resource  :profile,            only: [        :show,          :update          ] do
      resource :password,          only: [                        :update          ]
    end

    resources :news,               only: [:index, :show, :create, :update, :destroy]

    resources :users,              only: [:index, :show, :create,          :destroy] do
      collection do
        post :activate
      end
      member do
        post :approve
      end
    end

    resources :semesters,          only: [:index, :show, :create, :update, :destroy]

    resources :class_years,        only: [:index, :show, :create, :update, :destroy]

    resources :subjects,           only: [:index, :show, :create, :update, :destroy] do
      resources :documents,        only: [:index, :show                            ] do
        resources :document_files, only: [:index                                   ]
      end
    end

    resources :document_files,     only: [:index, :show, :create, :update, :destroy] do
      member do
        get :download_token
      end
    end

    match "*path" => "application#not_found", via: :all
  end

  namespace :contents do
    resources :document_files,     only: [                                         ] do
      member do
        get ':file_name', action: :render_file
      end
    end

    match "*path" => "application#not_found", via: :all
  end
end
