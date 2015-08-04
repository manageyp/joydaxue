# -*- encoding : utf-8 -*-

module Admin
  class UserLoginsController < BaseController

    def index
      parse_pagination
      @search = UserLogin.ransack(params[:q])
      @records = @search.result.page(@page).order("created_at desc")
    end

  end
end