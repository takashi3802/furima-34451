class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :move_to_index, only: [:index, :create]
  
  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
    if @item.purchase != nil
      redirect_to root_path
    end
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
     Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
     Payjp::Charge.create(
        amount: purchase_params[:price],  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user.id
  end
end