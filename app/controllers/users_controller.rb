class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit,:update,:edit, :destroy]
  before_action :set_user, only: [:update ,:edit, :destroy]
  before_action :move_to_index, only: [:show, :update ,:edit, :destroy]
  
  def show
    @user = User.find(params[:id])
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
     user.destroy
     redirect_to root_path
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day) 
  end

  def set_user
    user = User.find(params[:id])
  end

  def move_to_index
    user = User.find(params[:id])
    redirect_to root_path unless current_user.id == user.id
  end

  
end