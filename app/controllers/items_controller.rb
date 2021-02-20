class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end

  def create
    Item.create(item_params)
    render :index
  end

 private

  def item_params
    params.permit(:image,:name,:descriptions,:category_id,:status_id,:delivery_fee_id,:delivery_area_id,:delivery_day_id,:price).merge(user_id: current_user.id)
  end
end
