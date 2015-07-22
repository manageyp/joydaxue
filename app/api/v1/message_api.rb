# -*- coding: utf-8 -*-

module V1
  class MessageApi < BaseApi
    resource :messages do

      desc '获取用户消息数据接口'
      params do
        optional :token, type: String, desc: "用户的唯一标识"
        optional :page, type: String, desc: "客户端用户消息数据的最小创建时间"
      end

      get '/' do
        validate_user_token
        records, content = V1::MessageService.list_messages(params)
        render_datetime_pagination(records, content)
      end

      desc '获取用户未读消息状态接口'
      params do
        optional :token, type: String, desc: "用户的唯一标识"
      end

      get '/unread' do
        validate_user_token
        content = V1::MessageService.get_unread_count(params)
        render_json(data: content)
      end

      desc '删除用户消息接口'
      params do
        optional :message_id, type: String, desc: "数据类型 + 数据 ID"
        optional :token, type: String, desc: "用户的唯一标识"
      end

      post '/delete' do
        validate_user_token
        result, content = V1::MessageService.delete_message(params)
        if result
          render_json(data: content)
        else
          render_error(content)
        end
      end

    end
  end
end