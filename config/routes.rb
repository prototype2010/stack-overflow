Rails.application.routes.draw do
  root to: 'questions#index'

  post 'comments/create', as: 'create_comment'
  delete 'comments/destroy', as: 'delete_comment'

  post 'votes', to: 'votes#create', as: 'create_vote'
  delete 'votes', to: 'votes#destroy', as: 'delete_vote'

  get 'rewards',to: 'rewards#index', as: 'rewards'

  delete 'links/:id/delete',to: 'links#delete', as: 'delete_link'

  delete 'attachments/:id/purge',to: 'attachments#purge', as: 'purge_attachment'

  devise_for :users

  resources :questions, shallow: true do
    resources :answers, except: %i[new index] do
    end
  end

  mount ActionCable.server => '/cable'
end
