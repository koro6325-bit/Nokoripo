Rails.application.routes.draw do
  root 'top#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :onboardings, only: [] do
    collection do
      get :step1
      patch :update_step1
      get :step2
      post :create_step2
    end
  end

  resource :dashboard, only: [:show]

  # 💡 resources :payments の中に「一括クリア用のルート」を正しくネストさせます
  resources :payments, only: [:create, :destroy] do
    collection do
      delete :destroy_all
    end
  end
end


