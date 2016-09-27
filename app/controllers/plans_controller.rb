class PlansController < ApplicationController
  def index
    user = User.find(params[:id])
    @plans = user.most_current_twelve_months_of_plans
    @past_plans = user.past_plans
  end

  def show
  end
end
