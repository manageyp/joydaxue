# -*- encoding : utf-8 -*-

module Admin
  class UsersController < BaseController
    before_action :fetch_record, only: [:show, :edit, :update]

    def index
      parse_pagination
      @search = User.ransack(params[:q])
      @records = @search.result.page(@page)
    end

    def new
      @record = User.new
    end

    def show
    end

    def edit
    end

    def update
      if @record.refresh_info(protect_params)
        flash[:notice] = '修改成功'
        render action: 'show' and return
      end
    end

    def create
      @record = User.build(protect_params)
      if @record
        flash[:notice] = '添加成功'
        render action: 'show'
      else
        render action: 'new'
      end
    end

    # def destroy
    #   @record = User.find_by_id(params[:id])
    #   if @record && @record.destroy
    #     render text: 'success' and return
    #   else
    #     render text: '删除失败', status: 403 and return
    #   end
    # end

    private
      def fetch_record
        @record = User.find_by_id(params[:id])
        unless @record
          flash[:notice] = "记录不存在！"
          redirect_to admin_users_path and return
        end
      end

      def protect_params
        params.require(:user).permit(:name, :email, :cellphone, :display_name,
          :sex, :status)
      end

  end
end