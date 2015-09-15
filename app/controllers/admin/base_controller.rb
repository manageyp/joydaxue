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
        @user = User.where(name: session[:username]).first
        if !@user.is_active?
          flash[:error] = "您的账号被禁用，请联系管理员。"
          redirect_to root_path and return
        elsif super_admin? ||
          Permission.permitted?(@user, controller_name, action_name)
          return true
        else
          render template: "admin/common/unauthorized"
          return false
        end
      else
        flash[:error] = "请您先登录。"
        redirect_to root_path and return
      end
    end

    def super_admin?
      ['henrylee'].include?(session[:username])
    end

  end
end