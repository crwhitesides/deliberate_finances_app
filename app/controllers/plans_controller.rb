class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update]

  def index
    @plans = @user.current_twelve_months_of_plans
    @past_plans = @user.past_plans
  end

  def show
    @purchases_pending = @plan.purchases_pending
    @purchases_paid = @plan.purchases_paid_for
    @purchase = @plan.purchases.build price: 0
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @plan }
    end
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = "Your income was successfully updated!"
      redirect_to @plan
    else
      render 'edit'
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:income)
  end
end
