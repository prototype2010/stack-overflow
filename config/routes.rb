Rails.application.routes.draw do
  root to: 'questions#index'

  get 'rewards',to: 'rewards#index', as: 'rewards_path'
  delete 'links/:id/delete',to: 'links#delete', as: 'delete_link'
  delete 'attachments/:id/purge',to: 'attachments#purge', as: 'purge_attachment'

  devise_for :users

  resources :questions, shallow: true do
    resources :answers, except: %i[new index] do
    end
  end
end
