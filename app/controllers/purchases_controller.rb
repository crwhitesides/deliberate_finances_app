class PurchasesController < ApplicationController
  def index
  end

  def show
    if params[:plan_id]
      @plan = Plan.find_by(id: params[:plan_id])
      @purchase = @plan.purchases.find_by(id: params[:id])
      if @purchase.nil?
        flash[:warning] = "Purchase item not found."
        redirect_to current_user.current_plan
      end
    else
      @purchase = Purchase.find(params[:id])
    end
  end

  def new
    if params[:plan_id] && !Plan.exists?(params[:plan_id])
      flash[:warning] = "Plan not found."
      redirect_to current_user.current_plan
    else
      plan = Plan.find_by(id: params[:plan_id])
      @purchase = Purchase.new(plan_id: params[:plan_id])
    end
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      flash[:success] = "Planned purchase added successfully."
      redirect_to current_user.current_plan
    else
      render 'new'
    end
  end

  def edit
    if params[:plan_id]
      plan = Plan.find_by(id: params[:plan_id])
      if plan.nil?
        flash[:warning] = "Plan not found."
        redirect_to current_user.current_plan
      else
        @purchase = plan.purchases.find_by(id: params[:id])
        if @purchase.nil?
          flash[:warning] = "Purchase item not found."
          redirect_to current_user.current_plan
        end
      end
    else
      @purchase = Purchase.find(params[:id])
    end
  end

  def update
    @purchase = Purchase.find(params[:id])
    if @purchase.update(purchase_params)
      flash[:success] = "Planned purchase updated successfully."
      redirect_to current_user.current_plan
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def purchase_params
    params.require(:purchase).permit(:item, :price, :note, :plan_id)
  end
end
