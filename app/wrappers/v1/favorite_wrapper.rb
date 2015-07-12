# -*- encoding : utf-8 -*-

module V1
  class FavoriteWrapper < BaseWrapper

    class << self

      def favorite_info(user_id, favorite_id, is_favorite = true)
        ret = { favorite_id: favorite_id, is_favorite: is_favorite }

        user_token = UserToken.fetch_token(user_id)
        ret[:token] = user_token.token if user_token

        ret
      end

    end

  end
end