class PaymentsController < ApplicationController
  def new
    if params[:purchase_id] && !Purchase.exists?(params[:purchase_id])
      flash[:warning] = "Purchase not found."
      redirect_to current_user.current_plan
    else
      @payment = Payment.new(purchase_id: params[:purchase_id])
    end
  end

  def create
    @payment = Payment.new(payment_params)
    purchase = Purchase.find_by(id: params[:purchase_id])
    plan = purchase.plan
    if @payment.save
      flash[:success] = "Payment added successfully."
      redirect_to plan_purchase_path(plan, purchase)
    else
      render 'new'
    end
  end

  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :store, :purchase_id)
  end
end
