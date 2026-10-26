class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @payment = Payment.new # フォーム用

    # 1. 今月の利用額の合計を計算
    @total_payments_amount = current_user.payments.all_month_total_amount # ※後述のScope、または .sum(:amount) に変更
    # もしエラーが出る場合は一旦、簡易的に以下にしてください
    @total_payments_amount = current_user.payments.where(date: Time.zone.now.all_month).sum(:amount)

    # 2. ユーザーが設定した最大HP（今月の自由なお金）を取得
    allowance = @user.monthly_allowance || 0

    # 3. アクティブな目標（死守する金額）を取得
    active_target = current_user.targets.find_by(is_active: true)
    @target_budget = active_target ? active_target.total_budget : 0

    # 💡 4. コア演算ロジック：残りHP ＝ 最大HP － 死守する金額 － 今月の利用額
    @remaining_hp = allowance - @target_budget - @total_payments_amount
  end
end
