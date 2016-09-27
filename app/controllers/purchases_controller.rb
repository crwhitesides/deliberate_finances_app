class PurchasesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = current_user.current_plan.purchases.new(purchase_params)
    if @purchase.save
      redirect_to current_user.current_plan
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def purchase_params
    params.require(:purchase).permit(:item, :price, :note)
  end
end
