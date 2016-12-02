module UsersHelper
  def logged_in?
    current_user.id != nil
  end

  def past_plans_ids
    current_user.past_plans.map { |plan| plan.id }
  end
end
