class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @payment = current_user.payments.build(payment_params)
    @payment.date = Time.zone.today

    if @payment.save
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "支出を記録しました！" }
        # 💡 画面を遷移させず、フラッシュ部分だけをパッと書き換える処理
        format.turbo_stream do
          flash.now[:notice] = "支出を1秒記録しました！"
          render turbo_stream: turbo_stream.update("flash-messages", html: "<div style='background-color: #f0fdf4; color: #16a34a; padding: 0.75rem; border-radius: 0.375rem; border: 1px solid #bbf7d0; text-align: center; margin-bottom: 1rem; font-weight: bold;'>#{flash[:notice]}</div>")
        end
      end
    else
      redirect_to dashboard_path, alert: "登録に失敗しました。"
    end
  end

  # 💡 エラーの原因だった一括削除アクションをここに定義します！
  def destroy_all
    current_user.payments.destroy_all
    redirect_to dashboard_path, notice: "今月の履歴をすべてクリアしました！"
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :memo)
  end
end


