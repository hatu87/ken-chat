class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  # before_action :skip_if_signed_in, only: [:new, :create]

  def create

    @user = User.find_by_email(user_params[:email])
    if @user.nil?
      @user = User.new(user_params)
    else
      @user.assign_attributes(user_params)
    end

    # byebug
    if @user.save
      flash[:success] = "User is created"
      redirect_to login_path
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
