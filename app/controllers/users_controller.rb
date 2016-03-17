class UsersController < ApplicationController
  layout "guest"

  def create
    @user = User.new(user_params)
    # byebug
    if @user.save
      flash[:success] = "User is created"
      redirect_to new_session_path
    else
      @user.password_confirmation = params[:user][:password_confirmation]
      flash[:error] = "Error: Registration fail."
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.required(:user).permit(:name, :password, :email, :password_confirmation)
  end
end
