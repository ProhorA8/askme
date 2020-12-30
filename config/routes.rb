Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resources :questions, except: %i[show new index]

  get 'show' => 'users#show'
end
