Rails.application.routes.draw do
  resources :exchange_minors, only: [:index, :show]

  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      resources :exchange_minors, only: [:index, :show], defaults: { format: 'json' } do
        resources :exchange_requests, only: [:create], defaults: { format: 'json' }
      end
    end
  end

  get 'welcome/index'
  devise_for :users

  root 'welcome#index'
end
