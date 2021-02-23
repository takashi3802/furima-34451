class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_index, except: [:edit, :update]
  before_action :set_item, only:[:show, :edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to action: :index 

    # if @item == nil
    # redirect_to action: :index
    # end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :descriptions, :category_id, :status_id, :delivery_fee_id, :delivery_area_id,
                                 :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user.id
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
