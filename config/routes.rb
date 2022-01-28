Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users
  end
  resources :users, only: %i[new create edit update]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
