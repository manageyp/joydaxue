# -*- encoding : utf-8 -*-

module Util
  class DateUtil

    class << self

      def simple_data(value)
        if value.present?
           "#{value.strftime("%y-%m-%d  %H:%M")}"
        end
      end

      def diary_date(value)
        if value.present?
          "#{value.strftime("%Y-%m-%d")} #{week_day(value)}"
        end
      end

      def week_day(value)
        "星期" + ["天", "一", "二", "三", "四", "五", "六"][value.wday]
      end

      def remove_timezone(str)
        if str.present?
          time = Time.zone.parse(str)
          time.strftime("%Y-%m-%d %H:%M:%S") if time.present?
        end
      end

      def pagination_datetime(page)
        if page.to_i == 1
          ""
        else
          remove_timezone(page)
        end
      end

    end

  end
end