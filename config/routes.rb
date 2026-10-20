Rails.application.routes.draw do
  get 'top/index'
  # アプリのトップページ（起動時に開く画面）を指定
  root 'top#index'
  
  # トップページ以外の静的アクションが自動生成された記述（あればそのままでOK）
  get "top/index"
end
