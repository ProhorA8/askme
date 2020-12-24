Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resources :questions

  # get 'users/index'
  # get 'users/new'
  # get 'users/edit'
  # get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'show' => 'users#show'
end
