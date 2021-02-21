Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      resources :exchange_minors, only: [:index, :show], defaults: { format: 'json' }
      resources :minors, only: [:index, :show], defaults: { format: 'json' }
      resources :login, defaults: { format: 'json' }
      resources :profiles, only: [:index, :update], defaults: { format: 'json' }
    end
  end

  get 'welcome/index'

  resources :exchange_minor

  resources :profiles do
    resources :exchange_requests
  end
  resources :exchange_requests, only: [:create]

  resources :messages, only: [:new, :create]



  devise_for :users

  # root 'api/v1/minors#index'

  root 'welcome#index'
end
