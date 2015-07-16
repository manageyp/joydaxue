# -*- coding: utf-8 -*-

module V1
  class FollowApi < BaseApi
    resource :follows do

      desc '关注用户接口'
      params do
        optional :user_id, type: String, desc: "被关注用户 ID"
        optional :token, type: String, desc: "用户的唯一标识"
      end

      post '/' do
        validate_user_token
        result, content = V1::FollowService.follow(params)
        if result
          render_json(data: content)
        else
          render_error(content)
        end
      end

      desc '取消关注用户接口'
      params do
        optional :user_id, type: String, desc: "取消关注的用户 ID"
        optional :token, type: String, desc: "用户的唯一标识"
      end

      post '/cancel' do
        validate_user_token
        result, content = V1::FollowService.unfollow(params)
        if result
          render_json(data: content)
        else
          render_error(content)
        end
      end

    end
  end
end