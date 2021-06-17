Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      resources :login, defaults: { format: 'json' } do
        collection do
          get 'guest'
        end
      end

      devise_for :users do
        post 'auth/signin' => 'users/sessions#create', as: :user_session, defaults: { format: 'json' }
        delete 'users/delete' => 'users/sessions#destroy', :as => :destroy_user_session, defaults: { format: 'json' }
      end

      resources :guests, only: [:index], defaults: { format: 'json' }
      resources :exchange_minors, only: [:index, :show], defaults: { format: 'json' }
      resources :exchange_requests, only: [:index, :show, :create], defaults: { format: 'json' }
      resources :minors, only: [:index, :show], defaults: { format: 'json' }
      resources :profiles, only: [:index, :create], defaults: { format: 'json' }
      resources :messages, only: [:index, :create], defaults: { format: 'json' }
      resources :filters, only: [:index, :create], defaults: { format: 'json' }
    end
  end

  resources :welcome, only: [:index] do
    collection do
      post 'auth'
    end
  end

  resources :profiles do
    collection do
      resources :exchange_requests
    end
  end
  resources :exchange_minor
  # TODO: Дописать экшены
  # resources :exchange_requests, only: [:index, :create]
  resources :messages, only: [:new, :create]
  resources :filters, only: [:new, :index, :update]

  devise_for :users, skip: [:sessions]
  as :user do
    post 'auth/signin' => 'users/sessions#create', as: :user_session
    delete 'users/delete' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # get 'profile' => 'profiles#show'
  # get 'profile/edit' => 'profiles#edit'

  root 'welcome#index'
end
