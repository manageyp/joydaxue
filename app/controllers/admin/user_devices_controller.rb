# -*- encoding : utf-8 -*-

module Admin
  class UserDevicesController < BaseController

    def index
      parse_pagination
      @search = UserDevice.ransack(params[:q])
      @records = @search.result.page(@page).order("created_at desc")
    end

    def destroy
      device = UserDevice.find_by_id(params[:id])
      if device && device.destroy
        render text: 'success' and return
      else
        render text: '删除失败，请联系管理员', status: 403 and return
      end
    end

  end
end
