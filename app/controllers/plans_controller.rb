class PlansController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    @plans = user.current_twelve_months_of_plans
    @past_plans = user.past_plans
  end

  def show
  end
end
