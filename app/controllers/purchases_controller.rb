class PurchasesController < ApplicationController

  def index
   @purchase_address = PurchaseAddress.new(purchase_params)
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def  purchase_params
   params.permit(:postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone, :item_id).merge(user_id: current_user.id)
  end
end