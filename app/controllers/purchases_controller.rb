class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :move_to_index, only: [:index, :create]

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

  def purchase_params
    @item = Item.find(params[:item_id])
    params.require(:purchase_address).permit(:postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], price: @item.price, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: purchase_params[:price],
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
     if current_user.id == @item.user.id || @item.purchase != nil 
      redirect_to root_path
     end
  end
end
