class ItemsController < ApplicationController
  before_action :authenticate_user! , only: [:new]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if  @item.save
      redirect_to root_path
    else
      render :new
    end
  end

 private

  def item_params
    params.require(:item).permit(:image,:name,:descriptions,:category_id,:status_id,:delivery_fee_id,:delivery_area_id,:delivery_day_id,:price).merge(user_id: current_user.id)
  end
end
