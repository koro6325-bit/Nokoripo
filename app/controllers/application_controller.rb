class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録（サインアップ）時に追加のカラムを許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :monthly_allowance])
  end

  # 💡【重要】Deviseの通常の新規登録が成功した後のリダイレクト先
  def after_sign_up_path_for(resource)
    # ルーティングで定義されている「オンボーディングのステップ2（目標設定）」へ進む
    step2_onboardings_path
  end
end
