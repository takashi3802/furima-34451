class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit,:update,:edit, :destroy]
  before_action :move_to_index, only: [:show, :update ,:edit, :destroy]
  
  def show
    @user = User.find(params[:id])

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    card = Card.find_by(user_id: current_user.id) 

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) 
    @card = customer.cards.first
 end

  def update
    if current_user.update(user_params)
      sign_in(current_user, bypass:true)
      redirect_to root_path
    else
      redirect_to action: :edit
    end
  end

  def edit
  end

  def destroy
     user = User.find(params[:id])
     binding.pry
     user.destroy
     redirect_to root_path
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day) 
  end

  def move_to_index
    user = User.find(params[:id])
    redirect_to root_path unless current_user.id == user.id
  end

  
end