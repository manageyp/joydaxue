# -*- coding: utf-8 -*-

module V1
  class FavoriteApi < BaseApi
    resource :favorites do

      desc '用户添加收藏接口'
      params do
        optional :favorite_id, type: String, desc: "数据类型 + 数据 ID"
        optional :token, type: String, desc: "用户的唯一标识"
      end

      post '/' do
        validate_user_token
        content = V1::FavoriteService.collect(params)
        render_json(data: content)
      end

      desc '用户取消收藏接口'
      params do
        optional :favorite_id, type: String, desc: "数据类型 + 数据 ID"
        optional :token, type: String, desc: "用户的唯一标识"
      end

      post '/cancel' do
        validate_user_token
        content = V1::FavoriteService.uncollect(params)
        render_json(data: content)
      end

    end
  end
end