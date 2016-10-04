module PaymentsHelper
  def date_posted(payment)
    payment.created_at.strftime("%A, %b %e, %Y")
  end
end
