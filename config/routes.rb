Rails.application.routes.draw do
  scope :api do
    resources :users, only: :create
  end
end
