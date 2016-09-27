class PlansController < ApplicationController
  def index
    @plans = @user.current_twelve_months_of_plans
    @past_plans = @user.past_plans
  end

  def show
  end
end
