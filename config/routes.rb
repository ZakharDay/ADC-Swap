Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      resources :login, defaults: { format: 'json' } do
        collection do
          get 'guest'
        end
      end

      resources :exchange_minors, only: [:index, :show], defaults: { format: 'json' }
      resources :exchange_requests, only: [:index, :show, :create], defaults: { format: 'json' }
      resources :minors, only: [:index, :show], defaults: { format: 'json' }
      resources :profiles, only: [:index, :create], defaults: { format: 'json' }
      resources :messages, only: [:index, :create], defaults: { format: 'json' }
      resources :filters, only: [:index, :create], defaults: { format: 'json' }
    end
  end

  get 'welcome/index'

  resources :exchange_minor

  resources :profiles do
    resources :exchange_requests
  end
  resources :exchange_requests, only: [:create]

  resources :messages, only: [:new, :create]

  resources :filters, only: [:new, :index, :update]



  devise_for :users

  # root 'api/v1/minors#index'

  root 'welcome#index'
end
