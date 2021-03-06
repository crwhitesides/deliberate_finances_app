class PurchasesController < ApplicationController

  def show
    if params[:plan_id]
      @plan = Plan.find_by(id: params[:plan_id])
      @purchase = @plan.purchases.find_by(id: params[:id])

      if @purchase.nil?
        flash[:warning] = "Purchase not found."
        redirect_to current_user.current_plan
      else
        @payments = @purchase.payments
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
      @purchase = Purchase.new(plan_id: params[:plan_id])
    end
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      respond_to do |f|
        # flash[:success] = "Purchase added successfully."
        f.html { redirect_to current_user.current_plan }
        f.json { render json: @purchase, status: 201 }
      end
    else
      render json: { errors: @purchase.errors.full_messages }
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
          flash[:warning] = "Purchase not found."
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
      flash[:success] = "Purchase updated successfully."
      redirect_to current_user.current_plan
    else
      render 'edit'
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    flash[:success] = "Purchase deleted."
    redirect_to current_user.current_plan
  end

  private

  def purchase_params
    params.require(:purchase).permit(:item, :price, :note, :plan_id, tag_ids:[], tags_attributes: [:name])
  end
end
