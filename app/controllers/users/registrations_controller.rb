class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # 新規登録成功後にステップ1へリダイレクト
  def after_sign_up_path_for(resource)
    step1_onboardings_path
  end
end

