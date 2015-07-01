# -*- coding: utf-8 -*-

module V1
  class SchoolApi < BaseApi
    resource :schools do

      desc '获取学校列表接口'
      params do
        optional :token, type: String, desc: "用户的唯一标识"
        optional :page, type: String, desc: "客户端话题评论的最小更新时间"
      end

      get '/' do
        records, content = V1::SchoolService.list_schools(params)
        if records
          render_with_pagination(records, content)
        else
          render_error(content)
        end
      end

      desc '获取学校详情接口'
      params do
        optional :token, type: String, desc: "用户的唯一标识"
        optional :id, type: Integer, desc: "学校的数据库 ID"
      end

      get '/:id' do
        parse_user_token
        result, content = V1::SchoolService.get_school_detail(params)
        if result
          render_or_cache(data: content)
        else
          render_error(content)
        end
      end

    end
  end
end
