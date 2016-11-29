class PaymentsController < ApplicationController
  def index
    @payments = @user.payments
    render json: @payments
  end

  def new
    if params[:purchase_id] && !Purchase.exists?(params[:purchase_id])
      flash[:warning] = "Purchase not found."
      redirect_to current_user.current_plan
    else
      @payment = Payment.new(purchase_id: params[:purchase_id], user_id: session[:user_id])
    end
  end

  def create
    @payment = Payment.new(payment_params)
    purchase = Purchase.find_by(id: params[:purchase_id])
    plan = purchase.plan
    if @payment.save && !@payment.purchase_complete
      flash[:success] = "Payment added successfully."
      redirect_to plan_purchase_path(plan, purchase)
    elsif @payment.save && @payment.purchase_complete
      flash[:success] = "Payment added successfully."
      redirect_to current_user.current_plan
    else
      render 'new'
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    purchase = payment.purchase
    plan = purchase.plan

    payment.destroy
    flash[:success] = "Purchase deleted."
    redirect_to plan_purchase_path(plan, purchase)
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :store, :purchase_id, :user_id, :purchase_complete)
  end
end
