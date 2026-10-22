# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # ログイン中のユーザーに紐づいた新しい支払いデータを作成
    @payment = current_user.payments.build(payment_params)
    @payment.date ||= Time.current.to_date # 日付が入っていなければ今日の日付をセット

    if @payment.save
      # 保存に成功したら、緑色のメッセージを添えてメイン画面（ダッシュボード）にリダイレクト
      redirect_to dashboard_path, notice: "支出を記録しました！"
    else
      # 失敗した場合は、エラーメッセージを添えてダッシュボードに戻す
      redirect_to dashboard_path, alert: "保存に失敗しました。"
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :memo, :date)
  end
end
