# -*- encoding : utf-8 -*-

module V1
  class FavoriteService

    class << self

      def collect(params)
        Favorite.collect(params[:user_id], params[:favorite_id])
        V1::FavoriteWrapper.favorite_info(params[:user_id], params[:favorite_id])
      end

      def uncollect(params)
        Favorite.uncollect(params[:user_id], params[:favorite_id])
        V1::FavoriteWrapper.favorite_info(params[:user_id],
          params[:favorite_id], false)
      end

    end

  end
end