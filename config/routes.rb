Rails.application.routes.draw do
  # 未ログイン時のトップ画面
  root 'top#index'

  # Deviseの登録（registrations）コントローラをカスタム用に指定
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 新規登録後の初期設定ステップ用ルーティング
  resources :registrations_steps, only: [:show, :update]

  # メイン画面（ダッシュボード・メーター画面）
  resource :dashboard, only: [:show]
end
