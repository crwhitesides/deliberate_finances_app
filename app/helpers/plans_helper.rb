module PlansHelper
  def date_of(plan)
    if plan.date.year == Date.today.year
      plan.date.strftime("%B")
    else
      plan.date.strftime("%B '%y")
    end
  end

  def ids_of_past_plans(current_plan_id)
    arr = current_user.past_plans.map do |plan|
      plan.id
    end
    index_of_current_plan = arr.index(current_plan_id-1)
    arr[0..index_of_current_plan]
  end
end
