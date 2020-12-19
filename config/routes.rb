Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1, constraints: { format: 'json' } do
      get 'exchange_minors/index', defaults: { format: 'json' }
    end
  end

  get 'welcome/index'
  devise_for :users

  root 'welcome#index'
end
