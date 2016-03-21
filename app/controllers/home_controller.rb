class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :skip_if_signed_in

  def index
  end
end
