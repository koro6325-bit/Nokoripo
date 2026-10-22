# config/routes.rb
Rails.application.routes.draw do
  root 'top#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :registrations_steps, only: [:show, :update]
  resource :dashboard, only: [:show]
  
  
  resources :payments, only: [:create]
end

