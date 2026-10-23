class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # (既存のcreate処理のまま)
    @payment = current_user.payments.new(payment_params)
    @payment.date ||= Date.current
    if @payment.save
      redirect_to root_path, notice: "支出を記録しました！"
    else
      redirect_to root_path, alert: "記録に失敗しました"
    end
  end

  def destroy
    @payment = current_user.payments.find(params[:id])
    @payment.destroy
    redirect_to root_path, notice: "記録を削除しました！"
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :memo, :date)
  end
end

