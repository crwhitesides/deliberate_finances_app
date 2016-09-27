module PlansHelper
  def date_of(plan)
    if plan.date.year == Date.today.year
      plan.date.strftime("%B")
    else
      plan.date.strftime("%B '%y")
    end
  end
end
