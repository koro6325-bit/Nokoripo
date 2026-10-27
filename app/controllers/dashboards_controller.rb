class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # 💡 .includes(:payments) を追記して、ユーザーと一緒に利用履歴データも先読み（Eager Loading）します。
    # これにより、履歴をループ表示する際のN+1問題が完全に解消されます！
    @user = User.includes(:payments).find(current_user.id)
    
    @payment = Payment.new 
    @active_target = @user.targets.find_by(is_active: true)
  end
end


