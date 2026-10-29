class OnboardingsController < ApplicationController
  before_action :authenticate_user!

  def step1
    @user = current_user
  end

  def update_step1
    @user = current_user
    allowance_in_yen = params[:user][:monthly_allowance].to_i * 10000

    if @user.update(monthly_allowance: allowance_in_yen)
      redirect_to step2_onboardings_path
    else
      render :step1, status: :unprocessable_entity
    end
  end

  def step2
    @target = current_user.targets.build
  end

  def create_step2
    @target = current_user.targets.build(target_params)
    @target.is_active = true
    
    @target.deadline = Date.current.end_of_month

    if params[:target][:total_budget].present?
      @target.total_budget = params[:target][:total_budget].to_i * 10000
    end

    if @target.save
      redirect_to dashboard_path, notice: "初期設定が完了しました！現在の残りHPで死守していきましょう！"
    else
      flash.now[:alert] = "目標の設定に失敗しました。空欄がないか確認してください。"
      render :step2, status: :unprocessable_entity
    end
  end

  private

  def target_params
    params.require(:target).permit(:name, :total_budget)
  end
end


