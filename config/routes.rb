Rails.application.routes.draw do
  delete 'attachments/:id/purge',to: 'attachments#purge', as: 'purge_attachment'
  devise_for :users
  root to: 'questions#index'

  resources :questions, shallow: true do
    resources :answers, except: %i[new index] do
    end
  end
end
