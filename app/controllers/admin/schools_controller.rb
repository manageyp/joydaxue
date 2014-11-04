# -*- encoding : utf-8 -*-

module Admin
  class SchoolsController < BaseController
    before_action :fetch_record, only: [:show, :edit, :update]

    def index
      parse_pagination
      @search = School.ransack(params[:q])
      @records = @search.result.page(@page)
    end

    def new
      @record = School.new
    end

    def show
      @introduction = @record.school_introduction
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
      @record = School.build!(protect_params)
      if @record
        render action: 'show'
      else
        render action: 'new'
      end
    end

    # def destroy
    #   @record = School.find_by_id(params[:id])
    #   if @record && @record.destroy
    #     render text: 'success' and return
    #   else
    #     render text: '删除失败', status: 403 and return
    #   end
    # end

    private
      def fetch_record
        @record = School.find_by_id(params[:id])
        unless @record
          flash[:notice] = "记录不存在！"
          redirect_to admin_schools_path and return
        end
      end

      def protect_params
        params.require(:school).permit(:name)
      end

  end
end