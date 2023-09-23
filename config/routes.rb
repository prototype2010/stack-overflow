require 'sidekiq/web'

Rails.application.routes.draw do
  get 'search/index', as: 'search', to: 'search#index'
  get 'search/execute', as: 'execute_search', to: 'search#search'
  get 'subscriptions/create'
  get 'subscriptions/destroy'
  authenticate :user, lambda  { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'questions#index'

  post 'subscriptions/create', to: 'subscriptions#create', as: 'create_subscription'
  delete 'subscriptions/destroy', to: 'subscriptions#destroy', as: 'delete_subscription'

  post 'comments/create', as: 'create_comment'
  delete 'comments/destroy', as: 'delete_comment'

  post 'votes', to: 'votes#create', as: 'create_vote'
  delete 'votes', to: 'votes#destroy', as: 'delete_vote'

  get 'rewards',to: 'rewards#index', as: 'rewards'

  delete 'links/:id/delete',to: 'links#delete', as: 'delete_link'

  delete 'attachments/:id/purge',to: 'attachments#purge', as: 'purge_attachment'

  resources :questions, shallow: true do
    resources :answers, except: %i[new index] do
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end
      resources :questions, only:[:index, :show, :create, :update, :destroy] do
        resources :answers, only:[:index, :show, :create, :update, :destroy]
      end
      resources :users, only:[:index]
    end
  end

  mount ActionCable.server => '/cable'
end
