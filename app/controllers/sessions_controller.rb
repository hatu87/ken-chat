class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :skip_if_signed_in, only: [:new, :create]

  # show login form
  def new
    @user = User.new
    render 'new'
  end

  # login handler
  def create
    user = User.find_by_email(params[:email])
    # byebug
    begin
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_messages_path(user.id)
      else
        flash[:error] = 'Email or password is incorrectly.'
        render 'new'
      end

    rescue BCrypt::Errors::InvalidHash
      Rails.logger.fatal "Invalid password of user with id #{user.id}"
      flash[:error] = 'Your account is invalid. Please register a new account or contact our admin.'
      render 'new'
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def login_params
    params.permit(:email, :password)
  end
end
