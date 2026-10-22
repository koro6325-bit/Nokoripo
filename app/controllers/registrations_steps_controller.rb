# app/controllers/registrations_steps_controller.rb
class RegistrationsStepsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    case params[:id]
    when 'allowance'
      render 'allowance'
    when 'target'
      @target = @user.targets.build
      render 'target'
    else
      redirect_to root_path
    end
  end

  def update
    @user = current_user
    case params[:id]
    when 'allowance'
      if @user.update(user_params)
        redirect_to registrations_step_path(:target)
      else
        render 'allowance', status: :unprocessable_entity
      end
    when 'target'
      @target = @user.targets.build(target_params)
      if @target.save
        redirect_to dashboard_path
      else
        render 'target', status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:monthly_allowance)
  end

  def target_params
    params.require(:target).permit(:name, :total_budget, :deadline).merge(is_active: true)
  end
end
