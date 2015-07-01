# -*- encoding : utf-8 -*-

module V1
  class SchoolService

    class << self

      def list_schools(params)
        min_created_at = Util::DateUtil.remove_timezone(params[:page])
        schools = School.paginate_schools(min_created_at)
        [schools, V1::SchoolWrapper.schools_data(schools)]
      end

      def get_school_detail(params)
        school = School.fetch_school(params[:id])
        if school
          [school, V1::SchoolWrapper.school_detail(school)]
        else
          ErrorCode.error_content(:school_not_existed)
        end
      end

    end

  end
end