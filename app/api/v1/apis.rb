# -*- coding: utf-8 -*-

module V1
  module Apis

    def self.included(api)
      api.mount V1::UserApi
      api.mount V1::SchoolApi
      api.mount V1::FavoriteApi
      api.mount V1::FollowApi
      api.mount V1::MessageApi
    end

  end
end
