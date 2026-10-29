# app/models/target.rb
class Target < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :total_budget, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :deadline, presence: true

  # 新規作成・更新時にアクティブなら、既存のアクティブ目標を解除する
  before_save :ensure_single_active_target, if: :is_active?

  private

  def ensure_single_active_target
    # 自分以外の、このユーザーの現在アクティブな目標をすべてfalseにする
    user.targets.where(is_active: true).where.not(id: id).update_all(is_active: false)
  end
end
