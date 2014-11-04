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
      if session[:username].present?
        @username = session[:username]
      else
        @username = "test"
        #redirect_to root_path and return
      end
    end
  end
end