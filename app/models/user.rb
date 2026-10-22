# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :targets, dependent: :destroy
  has_many :payments, dependent: :destroy

  # 👈 ここにこの1行を追加します！金額は空欄禁止、0以上の数値のみ許可するルール
  validates :monthly_allowance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
end

