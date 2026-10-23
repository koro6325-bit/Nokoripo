# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  before_action :authenticate_user! # ログイン必須

  def show
    @user = current_user
    
    # 1. ユーザーが現在アクティブにしている目標（モチベ）を1つ取得
    @active_target = @user.targets.find_by(is_active: true)
    
    # 2. ユーザーが今月使ったお金（payments）の合計額を計算
    # ※月跨ぎ自動リセットの考慮：Rails側で当月（今月1日〜末日）のデータのみを合計する
    @total_payments_amount = @user.payments.where(date: Time.current.all_month).sum(:amount)
    
    # 3. 逆算残高メーターの演算ロジック（READMEより）
    # 残高 ＝ 当月の自由なお金 － 目標予算 － 今月の利用額合計
    if @active_target
      @remaining_hp = (@user.monthly_allowance || 0) - (@active_target.total_budget || 0) - @total_payments_amount
    else
      @remaining_hp = (@user.monthly_allowance || 0) - @total_payments_amount
    end

    # 新しく出費を入力するための空のオブジェクトを用意（Issue #12用）
    @payment = @user.payments.build
  end
end