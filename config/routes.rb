Rails.application.routes.draw do
  devise_for :users

  get "/dashboard" => 'dashboards#dashboard', as: :dashboard

  root 'homes#show'
end
