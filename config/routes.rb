Rails.application.routes.draw do
  devise_for :users

  root 'home#welcome'

  # namespace :api, defaults: {format: 'json'} do
  #   namespace :v1 do
  #     resources :events
  #   end
  # end

  namespace :api, path: '', defaults: {format: 'json'}, constraints: {subdomain: 'api'} do
    namespace :v1 do
      resources :events
    end
  end

end
