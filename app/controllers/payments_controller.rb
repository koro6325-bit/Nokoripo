# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    @payment = @user.payments.build(payment_params)
    @payment.date = Date.current

    if @payment.save
      flash.now[:notice] = "出費を記録しました！"
      render_turbo_stream
    else
      flash.now[:alert] = "金額を正しく入力してください。"
      render_turbo_stream_flash_only
    end
  end

  def destroy
    payment = @user.payments.find(params[:id])
    payment.destroy
    flash.now[:notice] = "記録を削除しました。"
    render_turbo_stream
  end

  def destroy_all
    @user.payments.where(date: Time.current.all_month).destroy_all
    flash.now[:notice] = "今月の履歴をすべてクリアしました。"
    render_turbo_stream
  end

  private

  def set_user
    @user = current_user
  end

  def payment_params
    params.require(:payment).permit(:amount, :memo)
  end

  def render_turbo_stream
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream do
        render turbo_stream: [
          # 1. メーター本体の更新
          turbo_stream.update("meter-section", partial: "dashboards/meter_section", locals: { user: @user }),
          
          #  2. 追記：「今月はまだ〇〇円しか使ってないよ！」のテキストエリアも同時に更新
          turbo_stream.update("payment-status", partial: "dashboards/payment_status", locals: { user: @user }),
          
          # 3. フラッシュメッセージの更新
          turbo_stream.update("flash-messages", partial: "shared/flash")
        ]
      end
    end
  end

  def render_turbo_stream_flash_only
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("flash-messages", partial: "shared/flash")
      end
    end
  end
end



