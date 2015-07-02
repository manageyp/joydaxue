# -*- encoding : utf-8 -*-

module Util
  class ValidateUtil

    USER_NAME = /^[a-z0-9\w_\p{Han}]*$/i
    USER_PASSWORD = /^[a-z0-9\w_]*$/i
    USER_EMAIL = /\A\s*([-a-z0-9+._]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i
    USER_CELLPHONE = /^1[3,4,5,8][0-9]{9}\Z/i
    USER_INT = /^\d*$/
    MOBILE_USER_AGENTS = 'android|ipad|iphone|ipod'

    class << self

      def valid_name?(value)
        if value.present?
          str = value.force_encoding('utf-8').encode
          str =~ USER_NAME
        end
      end

      def valid_name_length?(value)
        name_length = value.to_s.length
        name_length >= 2 && name_length <= 16
      end

      def valid_pwd?(value)
        if value.present?
          str = value.force_encoding('utf-8').encode
          str =~ USER_PASSWORD
        end
      end

      def valid_pwd_length?(value)
        pwd_length = value.to_s.length
        pwd_length >= 6 && pwd_length <= 16
      end

      def valid_email?(value)
        if value.present?
          str = value.force_encoding('utf-8').encode
          str =~ USER_EMAIL
        end
      end

      def valid_cellphone?(value)
        if value.present?
          str = value.force_encoding('utf-8').encode
          str =~ USER_CELLPHONE
        end
      end

      def is_mobile_device?(user_agent)
        user_agent.to_s.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
      end

    end

  end
end