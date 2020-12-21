Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      resources :exchange_minors, only: [:index, :show], defaults: { format: 'json' }
    end
  end

  get 'welcome/index'
  devise_for :users

  root 'welcome#index'
end
