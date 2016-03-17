class SessionsController < ApplicationController
  layout "guest"
  def new
    @user = User.new
    render 'new'
  end

  def create
    if User.where(login_params).count > 0
      flash[:success] = 'Login suceessfully.'
      redirect_to root_path
    else
      flash[:error] = 'Email or password is incorrectly.'
      render 'new'
    end
  end

  def destroy
  end

  private
  def login_params
    params.permit(:email, :password)
  end
end
