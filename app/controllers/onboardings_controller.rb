class OnboardingsController < ApplicationController
  before_action :authenticate_user!

  def step1
    @user = current_user
  end

  def update_step1
    @user = current_user
    # スライダー等は「万円」単位で送られてくるため、10000倍してDB（integer）に保存
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
    # ステップ2のフォームからデータを受け取り、Userに紐づけて保存
    @target = current_user.targets.build(target_params)
    @target.is_active = true
    
    # 死守する金額も「万円」単位なので10000倍する
    if params[:target][:total_budget].present?
      @target.total_budget = params[:target][:total_budget].to_i * 10000
    end

    if @target.save
      # 💡 ここでダッシュボード上部に表示される「バナー（通知）」をセットします！
      redirect_to dashboard_path, notice: "初期設定が完了しました！現在の残りHPで死守していきましょう！"
    else
      flash.now[:alert] = "目標の設定に失敗しました。空欄がないか確認してください。"
      render :step2, status: :unprocessable_entity
    end
  end

  private

  def target_params
    # 本来は期限(deadline)も受け取りますが、MVPで簡易にするため一旦名前のみでも動くように許可
    params.require(:target).permit(:name)
  end
end

