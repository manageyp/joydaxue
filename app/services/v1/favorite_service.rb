# -*- encoding : utf-8 -*-

module V1
  class FavoriteService

    class << self

      def collect(params)
        Favorite.collect(params[:current_user_id], params[:favorite_id])
        V1::FavoriteWrapper.favorite_info(params[:favorite_id])
      end

      def uncollect(params)
        Favorite.uncollect(params[:current_user_id], params[:favorite_id])
        V1::FavoriteWrapper.favorite_info(params[:favorite_id], false)
      end

      def list_favorites(params)
        min_created_at = if params[:page].to_i == 1
          ""
        else
          Util::DateUtil.remove_timezone(params[:page])
        end
        favorites = Favorite.list_user_favorites(params[:current_user_id], min_created_at)
        [favorites, V1::FavoriteWrapper.favorites_data(favorites)]
      end

    end

  end
end