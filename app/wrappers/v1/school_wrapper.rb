# -*- encoding : utf-8 -*-

module V1
  class SchoolWrapper < BaseWrapper

    class << self

      def school_detail(school)
        {
          school_id: school.id,
          name: school.name,
          address: school.address,
          share_link: "#{Settings.website}/html/schools/#{school.id}",
          favorite_id: school.favorite_id,
          updated_at: school.updated_at,
          created_at: school.created_at,
          images: school_images(school)
        }
      end

      def school_cache(school)
        cache_key = "school_wrapper_#{school.id}_#{school.updated_at.to_i}"
        cache_data = CacheService.get(cache_key)
        unless cache_data
          cache_data = school_detail(school)
          CacheService.set_week_expires(cache_key, cache_data)
        end
      end

      def schools_data(schools)
        ret = []
        if has_size?(schools)
          schools.each do |school|
            ret << school_cache(school)
          end
        end
        ret
      end

      def school_images(school)
        ret = []
        school_photos = school.school_photos
        if has_size?(school_photos)
          school_photos.each do |school_photo|
            ret << { thumb: small_image(school_photo.image),
              image: large_image(school_photo.image) }
          end
        end
        ret
      end

    end

  end
end
