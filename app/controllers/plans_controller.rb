class PlansController < ApplicationController
  def index
    @plans = @user.current_twelve_months_of_plans
    @past_plans = @user.past_plans
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
  end

  private

  def plan_params
    params.require(:plan).permit(:income)
  end
end
