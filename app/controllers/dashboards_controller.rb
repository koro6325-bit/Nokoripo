class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.includes(:payments).find(current_user.id)
    
    @payment = Payment.new 
    @active_target = @user.targets.find_by(is_active: true)
  end
end


