module Admin
  class BaseController < ActionController::Base
    layout 'admin'
    helper :admin
    protect_from_forgery
    before_action :authentication

    def parse_pagination
      @page = params[:page] || 1
      @per_page = params[:per_page] || 20
    end

    def authentication
      if session[:user_name].present?
        @user_name = session[:user_name]
      else
        redirect_to root_path
      end
    end
  end
end