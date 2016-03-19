class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    User.find_by_id(session[:user_id])
  end

  # def current_user(user)
  #   session[:user_id] = user.id
  # end

  def current_user_id
    session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def require_login
    unless signed_in?
      flash[:error] = 'You must sign in to see this page.'
      redirect_to login_path
    end
  end

  def skip_if_signed_in
    if signed_in?
      redirect_to user_messages_path(current_user)
    end
  end


  helper_method :current_user, :signed_in?, :current_user_id
end
