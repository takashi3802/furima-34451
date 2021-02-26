class PurchasesController < ApplicationController

  def index
   @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
       @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def  purchase_params
    params.require(:purchase_address).permit(:postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end