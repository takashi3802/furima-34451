class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
       pay_item
       @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def  purchase_params
    @item = Item.find(params[:item_id])
    params.require(:purchase_address).permit(:postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], price: @item.price, token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_b42b17087f0fb97891bb68e3"  
    Payjp::Charge.create(
        amount: purchase_params[:price],  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end
end