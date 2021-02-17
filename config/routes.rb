Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[show new index]
  resources :tags, param: :name, only: :show
end
