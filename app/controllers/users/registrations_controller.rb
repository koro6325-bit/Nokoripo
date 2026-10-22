# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # サインアップ（アカウント作成）成功後のリダイレクト先をステップ1へ
  def after_sign_up_path_for(resource)
    registrations_step_path(:allowance)
  end
end
