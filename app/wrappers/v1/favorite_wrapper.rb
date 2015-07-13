# -*- encoding : utf-8 -*-

module V1
  class FavoriteWrapper < BaseWrapper

    class << self

      def favorite_info(favorite_id, is_favorite = true)
        { favorite_id: favorite_id, is_favorite: is_favorite }
      end

      def favorite_detail(favorite)
        ret = { favorite_id: favorite.id, created_at: favorite.created_at }
        school = favorite.detail
        if school.present?
          ret[:detail] = V1::SchoolWrapper.school_detail(school)
        end
        ret
      end

      def favorites_data(favorites)
        ret = []
        favorites.each do |favorite|
          ret << favorite_detail(favorite)
        end
        ret
      end

    end

  end
end