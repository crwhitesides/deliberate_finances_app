class PlansController < ApplicationController
  def index
    @plans = @user.current_twelve_months_of_plans
    @past_plans = @user.past_plans
  end

  def show
    @plan = Plan.find(params[:id])
    @purchases = @plan.purchases_with_a_budget
    @purchases_paid = @plan.purchases_paid_for
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      flash[:success] = "Your income was successfully updated!"
      redirect_to @plan
    else
      render 'edit'
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:income)
  end
end
