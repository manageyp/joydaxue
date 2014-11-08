# -*- encoding : utf-8 -*-

module Admin
  class PermissionsController < BaseController

    def index
      prepare_search_form
      @admin_routes = Util::AdminResources.admin_routes(params[:refresh])
    end

    def create
      prepare_search_form
      Permission.build_permissions(@role_id_value, params[:action_names])
      @admin_routes = Util::AdminResources.admin_routes(true)
      flash[:notice] = '权限配置成功'
      render action: 'index'
    end

    private
      def prepare_search_form
        parse_pagination
        @role_id_value = params[:q][:role_id_eq] if params[:q]
        @search = Permission.ransack(params[:q])
        @records = @search.result.page(@page)
      end
  end
end