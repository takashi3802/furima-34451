class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def edit
    if current_user.save(user_params)
      sign_in(current_user, bypass:true)
      redirect_to root_path
    else
      redirect_to action: :edit
    end
  end

  def destroy
     user = User.find(params[:id])
     user.destroy
     redirect_to root_path
  end

  private

  def user_params
    params.permit(:nickname, :email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day) 
  end

end