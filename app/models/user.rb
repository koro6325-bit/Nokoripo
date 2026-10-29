class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :targets, dependent: :destroy
  has_many :payments, dependent: :destroy
  
  validates :monthly_allowance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update

  def remaining_hp
    # 1. 今月の自由なお金（未設定なら0）
    allowance = self.monthly_allowance || 0
    
    # 2. 現在アクティブな目標の予算（システム内で常に1つ。未設定なら0）
    active_target_budget = self.targets.find_by(is_active: true)&.total_budget || 0
    
    # 3. 今月のカード利用額の合計（「月跨ぎの挙動」要件に基づき、今月分のみを集計）
    current_month_payments_total = self.payments.where(date: Time.current.all_month).sum(:amount)
    
    # 計算：最大HP - 死守する金額 - 今月の利用額
    allowance - active_target_budget - current_month_payments_total
  end

  
  def current_month_total_payments
    self.payments.where(date: Time.current.all_month).sum(:amount)
  end
end

