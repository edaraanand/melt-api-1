Rails.application.routes.draw do
  devise_for :users

  # API
  namespace :api do
    namespace :v1 do
      resources :addresses, param: :uuid, only: [:index, :create, :show, :destroy]
    end
  end

  # UI
  resources :addresses, param: :uuid, only: [:index, :create, :show, :destroy]

  get "/dashboard" => 'dashboards#dashboard', as: :dashboard

  root 'homes#show'
end
